FactoryBot.define do
  factory :text_message do
    from { "15005550006" }
    to { "18015551234" }
    body { "MyText" }
    # multimedia "MyString"
    # message_id "MyString"
    # status 1
    # segments 1
    # cost "9.99"
    # sent_at "2018-07-11 17:33:06"
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
