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
        flash[:message] = "The answer was deleted successfully."
        redirect to "/questions/#{answer.question.id}"
      else
        flash[:message] = "The content couldn't be deleted."
        redirect to "/questions"
      end
    else
      redirect to "/login"
    end
  end
end
