require_relative './application_controller.rb'
class AnswersController < ApplicationController
  post '/questions/:id/answers' do
    question = Question.find_by_id(params[:id])
    question.answers.build(content:params[:content],user:current_user)
    if question.save
      redirect to "/questions/#{question.id}"
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
      redirect to "/login"
    end
  end

  get '/answers/:id/edit' do
    @answer = Answer.find_by_id(params[:id])
    erb :'/answers/edit'
  end

  patch '/answers/:id' do
    if is_logged_in?
      answer = current_user.answers.find_by_id(params[:id])
      if answer
        answer.update(params[:answer])
      end

      if answer.save
        flash[:success] = "Your answer was updated successfully."
        redirect to "/questions/#{answer.question.id}"
      else
        flash[:error] = "Unable to edit this content."
        redirect to "/questions"
      end
    else
      flash[:error] = "You need to login to view discount"
      redirect to "/login"
    end
  end
end
