class SearchesController < ApplicationController
  get "/search" do
    @users = User.where("name LIKE ? or username LIKE ? or email LIKE ?", "%#{params[:q]}%","%#{params[:q]}%","%#{params[:q]}%")
    @questions = Question.where("content LIKE ?","%#{params[:q]}%")
    erb :'/search/index'
  end
end
