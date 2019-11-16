class UsersController < ApplicationController
  get '/signup' do
    erb :'/users/new'
  end

  post '/signup' do
    user = User.new(params)
    if user.save
      session[:user_id] = user.id
      redirect to "/questions"
    else
      "#{user.errors.messages}"
    end
  end

  get '/login' do
    if !is_logged_in?
      erb :'login'
    else
      redirect to "/questions"
    end
  end

  post '/login' do
    user = User.find_by(username:params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/questions"
    else
      flash[:message] = "Please enter valid login information."
      redirect "/login"
    end
  end

  get '/logout' do
    if is_logged_in?
      session.clear
      redirect to "/login"
    else
      redirect to "/"
    end
  end
end
