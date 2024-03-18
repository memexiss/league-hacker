require "test_helper"
require "rails/test_help"

class TextMessageDeliverSmsJobTest < ActiveJob::TestCase
  let(:body) { "test body" }
  let(:text_message) { FactoryBot.create(:text_message) }
  it "sends a text message to a user" do
    VCR.use_cassette("text message deliver SMS job") do
      assert TextMessageDeliverSmsJob.perform_now(text_message.id)
    end
  end
end
