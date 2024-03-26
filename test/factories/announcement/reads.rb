FactoryBot.define do
  factory :announcement_read, class: 'Announcement::Read' do
    announcement { nil }
    user { nil }
    read_at { "2024-03-22 16:47:28" }
  end
end
