class GolfCourse::TeeBox < ApplicationRecord
  belongs_to :golf_course
  validate :tee, :slope, :handicap, :golf_course_id
end
