class League::Event < ApplicationRecord
  belongs_to :league, inverse_of: :events
  has_many :rounds, inverse_of: :event, dependent: :destroy
  has_many :teams, class_name: 'League::Event::Team', dependent: :destroy
  accepts_nested_attributes_for :rounds
  accepts_nested_attributes_for :teams
  has_many :flights

  enum status: {draft: 0, active: 5}
  enum event_type: {league: 0, tournament: 10}

  def self.status_select_options 
    statuses.keys.map {|x| [x.titleize, x]}
  end

  def self.event_type_select_options 
    event_types.keys.map {|x| [x.titleize, x]}
  end  
end
