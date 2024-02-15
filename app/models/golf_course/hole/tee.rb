class GolfCourse::Hole::Tee < ApplicationRecord
  belongs_to :hole, class_name: GolfCourse::Hole.name, primary_key: :id, foreign_key: :golf_course_hole_id
  validate :name, :color, :yards, :golf_course_hole_id
end
