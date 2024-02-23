class League::Event::Flight < ApplicationRecord
  belongs_to :event
  has_many :flight_memberships
  has_many :users, through: :flight_memberships
end
