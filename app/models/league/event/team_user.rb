class League::Event::TeamUser < ApplicationRecord
  belongs_to :team 
  belongs_to :user 
end
