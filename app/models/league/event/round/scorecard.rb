class League::Event::Round::Scorecard < ApplicationRecord
  belongs_to :round
  belongs_to :user 
  has_many :entries, inverse_of: :scorecard, dependent: :destroy
  accepts_nested_attributes_for :entries
end
