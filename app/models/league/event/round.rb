class League::Event::Round < ApplicationRecord
  belongs_to :event

  enum playing_format: {standard: 0, shamble: 10, scramble: 20, five_clubs_only: 30, red_white_blue: 40}
end
