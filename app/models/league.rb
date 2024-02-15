class League < ApplicationRecord
  has_many :events
  has_many :memberships

  enum league_type: {team: 0, individual: 10}
  validate :name, :payment_link, :league_type
end
