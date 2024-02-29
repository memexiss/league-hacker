class League::Event::Round::Scorecard::Entry < ApplicationRecord
  belongs_to :scorecard, class_name: League::Event::Round::Scorecard.name, primary_key: :id, foreign_key: :league_event_round_scorecard_id
  belongs_to :hole, class_name: GolfCourse::Hole.name, primary_key: :id, foreign_key: :golf_course_hole_id

end
