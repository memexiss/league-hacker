class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates_plausible_phone :phone, presence: true
  phony_normalize :phone, default_country_code: "US"
  validates :name, presence: true

  enum role: {default: 0, admin: 10}
end
