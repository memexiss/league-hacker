class League::Event < ApplicationRecord
  has_many :rounds
  has_many :flights

  enum status: {draft: 0, active: 5}
  enum event_type: {season: 0, tournament: 10}
end
