class Workout < ActiveRecord::Base
  belongs_to :user
  has_many :workout_parts
  has_many :parts, through: :workout_parts
end
