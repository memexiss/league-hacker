class League::Announcement < ApplicationRecord
  enum status: {draft: 0, published: 10}
  has_many :announcement_reads, class_name: 'League::Announcement::Read'
  has_many :readers, through: :announcement_reads, source: :user
  def self.status_select_options 
    statuses.keys.map {|x| [x.titleize, x]}
  end
  
end