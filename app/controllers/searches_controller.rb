class SearchesController < ApplicationController
  get "/search" do
    if is_logged_in?
      @users = User.where("name LIKE ? or username LIKE ? or email LIKE ?", "%#{params[:q]}%","%#{params[:q]}%","%#{params[:q]}%")
      @questions = Question.where("content LIKE ?","%#{params[:q]}%")
      erb :'/search/index'
    else
      flash[:error] = "You need to login to view this content."
      redirect to "/login"
    end
  end
end
