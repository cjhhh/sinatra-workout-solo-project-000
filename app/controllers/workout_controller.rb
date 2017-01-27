class WorkoutController < ApplicationController



  get '/workouts' do
    if logged_in?
      @muscles = ["Shoulders", "Chest", "Arms", "Abdominal", "Back", "Legs"]
      erb :'workouts/workouts'
    else
      redirect '/login'
    end
  end

end
