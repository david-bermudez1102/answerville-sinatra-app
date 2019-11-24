class ConnectionsController < ApplicationController
  post '/followers' do
    if is_logged_in?
      user = User.find_by(username:params[:username])
      if user && user!=current_user
        user.followers << current_user
        redirect to "/users/#{params[:username]}"
      else
        flash[:error] = "Error while following user. Please try again."
      end
    else
      flash[:error] = "You need to login first."
      redirect to "/login"
    end
  end

  delete '/followers/:username' do
    if is_logged_in?
      user = User.find_by(username:params[:username])
      follower = user.follower_connections.find_by(follower:current_user)
      if follower
        follower.delete
        redirect to "/users/#{params[:username]}"
      else
        flash[:error] = "Error while unfollowing user. Please try again."
      end
    else
      flash[:error] = "You need to login first."
      redirect to "/login"
    end
  end

  get '/followers' do
    if is_logged_in?
      erb :'/followers/index'
    else
      flash[:error] = "You need to login first."
      redirect to "/login"
    end
  end

  get '/following' do
    if is_logged_in?
      erb :'/following/index'
    else
      flash[:error] = "You need to login first."
      redirect to "/login"
    end
  end

  get '/followers/:username' do
    if is_logged_in?
      @user = User.find_by(username:params[:username])
      if @user
        erb :'/followers/show'
      else
        flash[:error] = "User does not exist."
        redirect to "/"
      end
    else
      flash[:error] = "You need to login first."
      redirect to "/login"
    end
  end

  get '/following/:username' do
    if is_logged_in?
      @user = User.find_by(username:params[:username])
      if @user
        erb :'/following/show'
      else
        flash[:error] = "User does not exist."
        redirect to "/"
      end
    else
      flash[:error] = "You need to login first."
      redirect to "/login"
    end
  end
end
