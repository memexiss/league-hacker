class League::Event::Round::Scorecard < ApplicationRecord
  belongs_to :round
  belongs_to :user 
  has_many :entries, inverse_of: :scorecard, dependent: :destroy
  
end
