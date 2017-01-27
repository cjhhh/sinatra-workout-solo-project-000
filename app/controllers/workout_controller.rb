class WorkoutController < ApplicationController



  get '/workouts' do
    if logged_in?
      @muscles = ["Shoulders", "Chest", "Arms", "Abdominal", "Back", "Legs"]
      erb :'workouts/workouts'
    else
      redirect '/login'
    end
  end

  get '/workouts/:part' do
    @part = Part.find_by(params[:part])
    erb :'workouts/show_workout'
  end

end
