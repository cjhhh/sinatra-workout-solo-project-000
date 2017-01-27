class WorkoutPart < ActiveRecord::Base
  belongs_to :workout
  belongs_to :part
end
