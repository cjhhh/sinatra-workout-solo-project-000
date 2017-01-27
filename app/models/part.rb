class Part < ActiveRecord::Base
  has_many :workout_parts
  has_many :workouts, through: :workout_parts
  has_many :users, through: :workouts
end
