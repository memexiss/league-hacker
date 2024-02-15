class League::Event < ApplicationRecord
  has_many :rounds
  has_many :flights

  status: {draft: 0, active: 5}
end
