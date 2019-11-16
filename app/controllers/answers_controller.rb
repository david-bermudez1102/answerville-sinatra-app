require_relative './application_controller.rb'
class AnswersController < ApplicationController
  post '/questions/:id/answers' do
    question = Question.find_by_id(params[:id])
    question.answers.build(content:params[:content],user:current_user)
    if question.save
      redirect to "/questions/#{question.id}"
    end
  end
end
