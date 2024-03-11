class League::Announcement < ApplicationRecord
  enum status: {draft: 0, published: 10}

  def self.status_select_options 
    statuses.keys.map {|x| [x.titleize, x]}
  end
  
end