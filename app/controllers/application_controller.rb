require 'securerandom'
require 'sinatra/flash'
require_relative '../helpers/helpers.rb'
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    register Sinatra::Flash
    set :session_secret, 'password_security'
  end

  get "/" do
    if is_logged_in?
      redirect to "/questions"
    else
      erb :index
    end
  end

  helpers do
    def is_logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def likes(o)
      if o.likes.count>0
        if o.likes.count==1
          "#{o.likes.count} Like."
        else
          "#{o.likes.count} Likes."
        end
      end
    end

    def categories
      categories = @question.categories.map do |category|
        category.name.downcase.capitalize
      end
    end
  end
end
