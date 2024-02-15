class League::Event::Round::Scorecard::Entry < ApplicationRecord
  belongs_to :scorecard
  belongs_to :hole
  
end
