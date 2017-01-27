class CreateWorkouts < ActiveRecord::Migration[5.0]
  def change
    create_table :workouts do |t|
      t.string :title
      t.string :content
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
