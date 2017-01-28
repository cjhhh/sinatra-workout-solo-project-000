require 'pry'
require 'rack-flash'

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
    if params[:user][:workout][:title] == "" || params[:user][:workout][:content] == "" || params[:user][:workout][:parts][:name] == ""
       flash[:message] = "You have left one of the fields blank, please try again."
       redirect '/workouts/new'
    else
      @workout = current_user.workouts.create(:title => params[:user][:workout][:title], :content => params[:user][:workout][:content])
      part = Part.find_by(:name => params[:user][:workout][:parts][:name])
      @workout.parts << part
    end
     redirect "/workouts/#{@workout.parts.first.name}"
  end

  get '/workouts/:muscle' do
    if logged_in?
      @part = Part.find_by(:name => params[:muscle])
      erb :'workouts/show_workout'
    else
      flash[:message] = "You cannot view that page until you have logged in. Please login to continue."
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end


end
