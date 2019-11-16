class QuestionsController < ApplicationController
  get '/questions' do
    if is_logged_in?
      erb :'/questions/index'
    else
      redirect to "/login"
    end
  end

  get '/questions/new' do
    if is_logged_in?
      erb :'/questions/new'
    else
      redirect to "/login"
    end
  end

  post '/questions' do
    if is_logged_in?
      question = current_user.questions.build(params)
      if question.save
        redirect to "/questions/#{question.id}"
      end
    else
      flash[:message] = "You need to login to view discount"
      redirect to "/login"
    end
  end

  get '/questions/:id/edit' do
    if is_logged_in?
      erb :'/questions/edit'
    else
      redirect to "/login"
    end
  end

  get '/questions/:id' do
    if is_logged_in?
      @question = Question.find_by_id(params[:id])
      if @question
        erb :'/questions/show'
      else
        flash[:message] = "The content does not exist."
        redirect to "/questions"
      end
    else
      redirect to "/login"
    end
  end
end
