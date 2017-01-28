require 'pry'
class WorkoutController < ApplicationController



  get '/workouts' do
    if logged_in?
      @muscles = ["Shoulders", "Chest", "Arms", "Abdominal", "Back", "Legs"]
      erb :'workouts/workouts'
    else
      redirect '/login'
    end
  end

  get '/workouts/new' do
    if logged_in?
     erb :'workouts/create_workout'
    else
      redirect '/login'
    end
  end

  post '/workouts' do
    binding.pry
@workout = current_user.workouts.create(:title => params[:user][:workout][:title], :content => params[:user][:workout][:content])

@workout.parts = current_user.parts.find_by(:name => params[:user][:workout][:parts][:name])

     redirect "/workouts/#{@workout.parts.name}"
  end

  get '/workouts/:muscle' do

    @part = Part.find_by(:name => params[:muscle])
    erb :'workouts/show_workout'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end


end
