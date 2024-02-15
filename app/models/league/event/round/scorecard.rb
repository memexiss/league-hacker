class League::Event::Round::Scorecard < ApplicationRecord
  belongs_to :round
  belong_to :user 
  has_many :scorecard_entries 

end
