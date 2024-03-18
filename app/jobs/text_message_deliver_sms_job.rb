class TextMessageDeliverSmsJob < ApplicationJob
  queue_as :instant

  def perform(text_message_id)
    t = TextMessage.find text_message_id
    t.deliver_sms!
  end
end
