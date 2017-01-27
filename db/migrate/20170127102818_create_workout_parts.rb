class CreateWorkoutParts < ActiveRecord::Migration[5.0]
  def change
    create_table :workout_parts do |t|
      t.integer :workout_id
      t.integer :part_id
      t.timestamps null: false
    end 
  end
end
