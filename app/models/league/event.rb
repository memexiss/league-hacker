class League::Event < ApplicationRecord
  has_many :rounds
  has_many :flights

  enum status: {draft: 0, active: 5}
end
