class League::Event::FlightMembership < ApplicationRecord
  belongs_to :flight 
  belongs_to :user
end
