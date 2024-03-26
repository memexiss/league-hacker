class League::Event::Team::TeamUser < ApplicationRecord
  belongs_to :team 
  belongs_to :user 
end
