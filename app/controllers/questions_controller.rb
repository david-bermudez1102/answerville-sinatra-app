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
      question = current_user.questions.build(params[:question])
      if !params[:category][:name].empty?
        category = Category.find_by(params[:category])
        if !category
          question.categories.build(params[:category])
        else
          question.categories << category
        end
      end
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
      @question = Question.find_by_id(params[:id])
      erb :'/questions/edit'
    else
      redirect to "/login"
    end
  end

  patch '/questions/:id' do
    if is_logged_in?
      question = current_user.questions.find_by_id(params[:id])
      if question
        question.update(params[:question])
        if !params[:category][:name].empty?
          category = Category.find_by(params[:category])
          if !category
            question.categories.build(params[:category])
          else
            question.categories << category unless question.categories.include?category
          end
        end
      end

      if question.save
        redirect to "/questions/#{question.id}"
      else
        flash[:message] = "Unable to edit this content."
        redirect to "/questions"
      end
    else
      flash[:message] = "You need to login to view discount"
      redirect to "/login"
    end
  end

  delete '/questions/:id/delete' do
    if is_logged_in?
      question = current_user.questions.find_by_id(params[:id])
      if question
        question.delete
        flash[:message] = "The content was deleted successfully."
        redirect to "/questions"
      else
        flash[:message] = "The content couldn't be deleted."
        redirect to "/questions"
      end
    else
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
