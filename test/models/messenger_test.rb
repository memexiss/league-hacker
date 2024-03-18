# frozen_string_literal: true

require "test_helper"

class MessengerTest < ActiveSupport::TestCase
  let(:phone_number) { "+14074431720" }

  setup do
    @messenger = Messenger.new
  end

  it "must create message" do
    VCR.use_cassette("messenger test create_message") do
      @messenger.message("HEY its a message", to: phone_number)
      assert @messenger.sms
      assert_equal phone_number, @messenger.sms.to
      assert_equal Rails.application.credentials.dig(:twilio, :phone_number).to_s, @messenger.sms.from
      assert_equal "queued", @messenger.sms.status
      assert_equal "HEY its a message", @messenger.sms.body
    end
  end

  it "must create message with a to" do
    VCR.use_cassette("messenger test create message with to") do
      @messenger.message("HEY its a message", to: phone_number)
      assert @messenger.sms
      assert_equal phone_number, @messenger.sms.to
      assert_equal Rails.application.credentials.dig(:twilio, :phone_number).to_s, @messenger.sms.from
      assert_equal "queued", @messenger.sms.status
      assert_equal "HEY its a message", @messenger.sms.body
    end
  end

  it "will raise error create message with a bad to" do
    VCR.use_cassette("create message with invalid to") do
      assert_raises Twilio::REST::RestError do
        @messenger.message("HEY its a message", to: "+10001234567")
        @messenger.sms
      end
    end
  end

  it "must create picture message" do
    VCR.use_cassette("messenger test create picture message", match_requests_on: [:query]) do
      @messenger.message("HEY its a picture message", media_url: "https://www.placecage.com/c/150/150", to: phone_number)
      assert @messenger.sms
      assert_equal phone_number, @messenger.sms.to
      assert_equal Rails.application.credentials.dig(:twilio, :phone_number).to_s, @messenger.sms.from
      assert_equal "queued", @messenger.sms.status
      assert_equal "HEY its a picture message", @messenger.sms.body
    end
  end

  it "must create picture message with a to" do
    VCR.use_cassette("messenger test create picture message with to", match_requests_on: [:query]) do
      @messenger.message("HEY its a picture message", media_url: "https://www.placecage.com/c/150/150", to: phone_number)
      assert @messenger.sms
      assert_equal phone_number, @messenger.sms.to
      assert_equal Rails.application.credentials.dig(:twilio, :phone_number).to_s, @messenger.sms.from
      assert_equal "queued", @messenger.sms.status
      assert_equal "HEY its a picture message", @messenger.sms.body
    end
  end
end
