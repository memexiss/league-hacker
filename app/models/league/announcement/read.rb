class League::Announcement::Read < ApplicationRecord
  belongs_to :user
  belongs_to :league_announcement, class_name: 'League::Announcement'
end
