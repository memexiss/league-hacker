class League < ApplicationRecord
  has_many :events, inverse_of: :league, dependent: :destroy
  accepts_nested_attributes_for :events
  has_many :memberships
  has_one_attached :logo

  enum league_type: {team: 0, individual: 10}
  validate :name, :payment_link, :league_type
end
