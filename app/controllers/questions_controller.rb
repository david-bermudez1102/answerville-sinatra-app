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
      else
        flash[:error] = err(question)
        redirect to "/questions/new"
      end
    else
      flash[:error] = "You need to login to view discount"
      redirect to "/login"
    end
  end

  get '/questions/:id/edit' do
    if is_logged_in?
      @question = current_user.questions.find_by(id:params[:id])
      if @question
        erb :'/questions/edit'
      else
        flash[:error] = "You can't edit this question."
        redirect to "/questions/#{params[:id]}"
      end
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
        flash[:error] = "Unable to edit this content."
        redirect to "/questions"
      end
    else
      flash[:error] = "You need to login to view discount"
      redirect to "/login"
    end
  end

  delete '/questions/:id' do
    if is_logged_in?
      question = current_user.questions.find_by_id(params[:id])
      if question
        question.destroy
        flash[:error] = "The content was deleted successfully."
        redirect to "/questions"
      else
        flash[:error] = "The content couldn't be deleted."
        redirect to "/questions"
      end
    else
      flash[:error] = "You need to login to view this content."
      redirect to "/login"
    end
  end

  get '/questions/:id' do
    if is_logged_in?
      @question = Question.find_by_id(params[:id])
      if @question
        erb :'/questions/show'
      else
        flash[:error] = "The content couldn't be deleted."
        redirect to "/questions"
      end
    else
      redirect to "/login"
    end
  end
end
