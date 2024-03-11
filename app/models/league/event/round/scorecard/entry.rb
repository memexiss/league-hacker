class League::Event::Round::Scorecard::Entry < ApplicationRecord
  belongs_to :scorecard, class_name: League::Event::Round::Scorecard.name
  belongs_to :hole, class_name: GolfCourse::Hole.name
end
