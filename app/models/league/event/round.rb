class League::Event::Round < ApplicationRecord
  belongs_to :event, inverse_of: :rounds
  has_many :scorecards
  
  enum playing_format: {standard: 0, shamble: 10, scramble: 20, five_clubs_only: 30, red_white_blue: 40}
  enum scoring_format: {gross: 0, net: 10, best_of: 20, chicago: 30, stableford: 40 }

  def self.playing_format_select_options 
    playing_formats.keys.map {|x| [x.titleize, x]}
  end

  def self.scoring_format_select_options 
    scoring_formats.keys.map {|x| [x.titleize, x]}
  end  
end
