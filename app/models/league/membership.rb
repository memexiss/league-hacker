class League::Membership < ApplicationRecord
  belongs_to :league 
  belongs_to :user

  enum membership_type: {manager: 0, player: 10}
end
