class TextMessageUpdateSmsDetailsJob < ApplicationJob
  queue_as :default

  def perform(text_message_id)
    t = TextMessage.find text_message_id
    t.with_twilio!
  end
end
