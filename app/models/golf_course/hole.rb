class GolfCourse::Hole < ApplicationRecord
  has_many :tees, inverse_of: :hole, dependent: :destroy
  has_many :entries
  belongs_to :golf_course, class_name: GolfCourse.name, primary_key: :id, foreign_key: :golf_course_id
  accepts_nested_attributes_for :tees
  validate :hole, :par, :handicap, :golf_course_id
end
