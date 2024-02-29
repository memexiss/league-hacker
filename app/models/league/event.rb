class League::Event < ApplicationRecord
  belongs_to :league, inverse_of: :events
  has_many :rounds, inverse_of: :event, dependent: :destroy
  accepts_nested_attributes_for :rounds
  has_many :flights

  enum status: {draft: 0, active: 5}
  enum event_type: {league: 0, tournament: 10}
end
