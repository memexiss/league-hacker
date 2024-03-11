class League::Event::Team < ApplicationRecord
  belongs_to :event
  has_many :users, through: :team_users
  has_many :team_users, dependent: :destroy
  enum handicap_format: {player_average: 0, manual_input: 5, not_one: 10} 
end
  