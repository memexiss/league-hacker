require "test_helper"

class TextMessageUpdateSmsDetailsJobTest < ActiveJob::TestCase
  let(:body) { "test body" }
  let(:text_message) { FactoryBot.create(:text_message, message_id: 123, sent_at: Time.current) }
  it "sends a text message to a user" do
    assert TextMessageUpdateSmsDetailsJob.perform_now(text_message.id)
  end
end
