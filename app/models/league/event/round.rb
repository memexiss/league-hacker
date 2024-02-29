class League::Event::Round < ApplicationRecord
  belongs_to :event, inverse_of: :rounds
  has_many :scorecards
  
  enum playing_format: {standard: 0, shamble: 10, scramble: 20, five_clubs_only: 30, red_white_blue: 40}
end
