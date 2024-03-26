class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates_plausible_phone :phone, presence: true
  phony_normalize :phone, default_country_code: "US"
  validates :password, :email, :first_name, :last_name, presence: true
  has_many :memberships, dependent: :destroy, class_name: League::Membership.name
  has_many :announcement_reads, class_name: 'League::Announcement::Read'
  has_many :league_announcements, through: :announcement_reads

  enum role: {default: 0, admin: 10}

  def full_name
    "#{first_name} #{last_name}"           
   end
end
