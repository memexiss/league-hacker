class League::Event::Team < ApplicationRecord
  belongs_to :event
  has_many :users, through: :team_users
  enum handicap_format: {player_average: 0, manual_input: 5, none: 10} 
end
