class GolfCourse < ApplicationRecord
  has_many :holes, inverse_of: :golf_course, dependent: :destroy
  has_many :tee_boxes, inverse_of: :golf_course, dependent: :destroy
  accepts_nested_attributes_for :holes
  accepts_nested_attributes_for :tee_boxes
  validate :name, :address, :city, :latitude, :longitude, :country, :fairway_grass, :green_grass, :number_of_holes, :length_format, :phone, :state, :website, :zip
end
