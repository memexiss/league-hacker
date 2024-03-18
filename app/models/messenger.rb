# frozen_string_literal: true

require "twilio-ruby"

class Messenger
  attr_accessor :client, :sms

  def initialize
    @client = Twilio::REST::Client.new Rails.application.credentials.dig(:api, :twilio, :id), Rails.application.credentials.dig(:api, :twilio, :token)
  end

  def message(body, to:, from: Rails.application.credentials.dig(:api, :twilio, :phone_number), media_url: nil)
    data = {
      from: from,
      to: to,
      body: body,
      risk_check: "disable"
    }
    data[:media_url] = media_url if media_url.present?
    @sms = client.api.account.messages.create(**data)
  end

  # :skip_test_coverage:
  def find(twilio_sid)
    client.api.account.messages(twilio_sid).fetch
  end
  # :skip_test_coverage:
end
