# frozen_string_literal: true

require "test_helper"

class TextMessageTest < ActiveSupport::TestCase
  let(:text_message) { FactoryBot.build(:text_message) }
  let(:sent_message) do
    VCR.use_cassette("create_text_message") do
      FactoryBot.create(:text_message)
    end
  end

  describe "TextMessage" do
    it "should create a valid text_message" do
      assert text_message.valid?
    end
    it "should create an invalid text_message" do
      text_message.body = nil
      refute text_message.valid?
    end
    it "should response to its associations" do
      assert_respond_to text_message, :owner
      # assert_respond_to text_message, :invitation
    end
  end

  describe ".set_from" do
    it "should set from to the default with the set_from method" do
      assert_not_nil text_message.from
      text_message.from = nil
      assert_nil text_message.from
      text_message.set_from
      assert_not_nil text_message.from
      text_message.from = "14074431720"
      text_message.set_from
      assert_equal "14074431720", text_message.from
    end
  end

  describe ".deliver_sms!" do
    it "deliver the SMS " do
      VCR.use_cassette("deliver sms") do
        text_message.save
        assert text_message.deliver_sms!
      end
    end
  end

  describe "self.search" do
    it "should return results that match the search" do
      TextMessage.delete_all
      VCR.use_cassette("create_two_messages") do
        create(:text_message, to: "14074437130")
        create(:text_message, to: "14074437120")
      end
      assert_equal 1, TextMessage.search("7130").count
      assert_equal 2, TextMessage.search("443").count
    end
  end

  describe "get recipient" do
    it "should return recipient of message" do
      entity_membership_for_supervisor = create(:entity_membership, :supervisor, :for_location)
      survey = create(:survey, mood_score: 2, energy_score: 2, notes: "I'm sorry for unavailable.", entity_membership: entity_membership_for_supervisor)

      survey.text_messages.map { |a| a.recipient&.name }.join(", ")
      assert_equal survey.text_messages.last.to, survey.user.mobile_phone
    end
  end
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
