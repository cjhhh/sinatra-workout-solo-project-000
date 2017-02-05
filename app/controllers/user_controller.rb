require 'rack-flash'

class UserController < ApplicationController

  use Rack::Flash

  get '/signup' do
     erb :'users/signup'
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/workouts'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    elsif User.find_by(:username => params[:username]) || User.find_by(:email => params[:email])
      flash[:message] = "That Username or Email is already in use. Please Try again."
      redirect '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      flash[:message] = "and thank you for signing up to workout fanatic!"
      redirect '/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if params[:username] == "" || params[:password] == ""
      flash[:message] = "You have not entered a Username or Password. Please Try again."
      redirect '/login'
    elsif @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/workouts'
    else
      flash[:message] = "We could not verify you in our system. You have entered an incorrect Password or Username. Please sign up to continue or click the link at the bottom to try again."
      redirect '/signup'
    end
  end

  get "/users/:slug" do
    erb :'users/show'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end


end
