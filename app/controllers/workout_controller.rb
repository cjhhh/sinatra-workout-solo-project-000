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

  get '/workout/:id' do
    @workout = Workout.find(params[:id])
    erb :'/workouts/show_single_workout'
  end

  get '/workout/:id/edit' do
    if logged_in?
      @workout = Workout.find(params[:id])
      @workout.user_id == current_user.id
      erb :'/workouts/edit_workout'
    else
      redirect '/login'
    end
  end

  patch '/workouts/:id' do
    if params[:title] == "" || params[:content] == ""
      redirect "/tweets/#{params[:id]}/edit"
    else
      @workout = Workout.find(params[:id])
      @workout.title = params[:title]
      @workout.content = params[:content]
      @workout.save
      redirect "/workout/#{@workout.id}"
    end
  end

  delete '/workouts/:id/delete' do
    @workout = Workout.find(params[:id])
    if logged_in? && current_user.id ==  @workout.user_id
      @workout.delete
      redirect "/users/#{current_user.username}"
    end
  end




end
