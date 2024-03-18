# frozen_string_literal: true

class TextMessage < ApplicationRecord
  enum status: [:initial, :queued, :delivered, :sent, :failed, :undelivered]
  scope :search, ->(search_term) { where("\"to\" ilike ?", "%#{search_term}%") }
  belongs_to :owner, optional: true
  belongs_to :survey, optional: true

  validates :body, presence: true

  after_initialize :set_from
  after_create :send_sms

  def set_from
    self.from ||= Rails.env.production? ? Rails.application.credentials.dig(:twilio, :phone_number) : "09877654397"
  end

  def recipient
    User.find_by(mobile_phone: to)
  end

  def send_sms
    return if Rails.env.development?
    TextMessageDeliverSmsJob.set(wait: 3.seconds).perform_later id
  end

  def deliver_sms!
    sms = Messenger.new.message(body, to: to, from: self.from, media_url: multimedia)
    # :skip_test_coverage:
    if Rails.env.production?
      set_twilio_details(sms) if /Twilio/.match?(sms.class.name)
    end
    # :skip_test_coverage:
    self
  end

  # :skip_test_coverage:
  # Twilio doesn't allow fetch sms in test mode
  def with_twilio!
    return self if sent_at.present?
    if messenger_sms.sid
      set_twilio_details(messenger_sms)
      reload
    end
  end

  private

  def messenger_sms
    Messenger.new.find message_id
  end

  def set_twilio_details(sms)
    self.message_id = sms.sid
    self.status = sms.status
    self.sent_at = sms.date_sent
    if sms.price&.to_d.present?
      self.cost += sms.price&.to_d
    end
    self.segments += sms.num_segments.to_i
    save
    TextMessageUpdateSmsDetailsJob.set(wait: 30.seconds).perform_later(id) unless sent_at && sent_at > 10.minutes.ago
  end
  # :skip_test_coverage:
end

# == Schema Information
#
# Table name: text_messages
#
#  id         :bigint           not null, primary key
#  body       :text
#  cost       :decimal(, )      default(0.0)
#  from       :string           not null
#  multimedia :string
#  segments   :integer          default(0)
#  sent_at    :datetime
#  status     :integer          default("initial")
#  to         :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  coach_id   :integer
#  message_id :string
#
# Indexes
#
#  index_text_messages_on_coach_id  (coach_id)
#
