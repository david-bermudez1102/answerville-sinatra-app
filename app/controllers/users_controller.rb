class UsersController < ApplicationController
  get '/signup' do
    if is_logged_in?
      redirect to "/questions"
    else
      erb :'/users/new'
    end
  end

  post '/signup' do
    user = User.new(params)
    if user.save
      session[:user_id] = user.id
      redirect to "/questions"
    else
      flash[:error] = err(user)
      redirect to "/signup"
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
      flash[:error] = "Please enter valid login information."
      redirect "/login"
    end
  end

  get '/users/:username/edit' do
    user = User.find_by(username:params[:username])
    if user==current_user
      erb :'/users/edit'
    else
      flash[:error] = "The page you requested does not exist."
      redirect to "/users/#{params[:username]}"
    end
  end

  patch '/users/:username' do
    user = User.find_by(username:params[:username])
    if user==current_user
      if user.authenticate(params[:user][:password])
        if params[:new_password].empty?
          user.update(params[:user])
        else
          params[:user][:password] = params[:new_password]
          user.update(params[:user])
        end
      else
        flash[:error] = "Wrong password. Please try again."
        redirect to "/users/#{params[:username]}/edit"
      end

      if user.save
        redirect to "/logout"
      else
        flash[:error] = err(user)
        redirect to "/users/#{params[:username]}/edit"
      end
    else
      flash[:error] = "The page you requested does not exist."
      redirect to "/users/#{params[:username]}"
    end
  end

  get '/users/:username' do
    @user = User.find_by(username:params[:username])
    erb :'/users/show'
  end

  get '/logout' do
    if is_logged_in?
      session.clear
      flash[:success] = "You've been logged out."
      redirect to "/login"
    else
      redirect to "/"
    end
  end
end
