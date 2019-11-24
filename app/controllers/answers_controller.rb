require_relative './application_controller.rb'
class AnswersController < ApplicationController
  post '/questions/:id/answers' do
    if is_logged_in?
      question = Question.find_by_id(params[:id])
      if !question.answered
        question.answers.build(content:params[:content],user:current_user)
      end
      if question.save
        redirect to "/questions/#{question.id}"
      else
        flash[:error] = "Unable to save your answer."
      end
    else
      flash[:error] = "You need to login to view this content."
      redirect to "/login"
    end
  end

  delete '/answers/:id' do
    if is_logged_in?
      answer = current_user.answers.find_by_id(params[:id])
      if answer
        answer.delete
        flash[:error] = "The answer was deleted successfully."
        redirect to "/questions/#{answer.question.id}"
      else
        flash[:error] = "The content couldn't be deleted."
        redirect to "/questions"
      end
    else
      flash[:error] = "You need to login to view this content."
      redirect to "/login"
    end
  end

  get '/answers/:id/edit' do
    if is_logged_in?
      @answer = current_user.answers.find_by_id(params[:id])
      if @answer && !@answer.question.answered
        erb :'/answers/edit'
      else
        flash[:error] = "Unable to edit this answer."
        redirect to "/questions/#{@answer.question.id}"
      end
    else
      flash[:error] = "You need to login to view this content."
      redirect to "/login"
    end
  end

  patch '/answers/:id' do
    if is_logged_in?
      answer = current_user.answers.find_by_id(params[:id])
      if answer && !answer.question.answered
        answer.update(params[:answer])
      end

      if answer.save
        flash[:success] = "Your answer was updated successfully."
        redirect to "/questions/#{answer.question.id}"
      else
        flash[:error] = "Unable to edit this answer."
        redirect to "/questions"
      end
    else
      flash[:error] = "You need to login to view this content."
      redirect to "/login"
    end
  end

  get '/users/:username/answers' do
    if is_logged_in?
      @user = User.find_by_username(params[:username])
      erb :'/answers/show'
    else
      flash[:error] = "You need to login to view this content."
      redirect to "/login"
    end
  end
end
