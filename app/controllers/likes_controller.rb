class LikesController < ApplicationController
  post '/questions/:id/likes' do
    question = Question.find_by_id(params[:id])
    like_question = question.likes.find_by(user:current_user)
    if !like_question
      question.likes.build(user:current_user)
    end

    if question.save
      redirect to "/questions/#{question.id}"
    else
      redirect to "/questions/#{question.id}"
    end
  end

  delete '/questions/:id/likes' do
    question = Question.find_by_id(params[:id])
    like_question = question.likes.find_by(user:current_user)
    if like_question
      like_question.delete
      redirect to "/questions/#{question.id}"
    else
      redirect to "/questions/#{question.id}"
    end
  end

  post '/answers/:id/likes' do
    answer = Answer.find_by_id(params[:id])
    like_answer = answer.likes.find_by(user:current_user)
    if !like_answer
      answer.likes.build(user:current_user)
    end

    if answer.save
      redirect to "/questions/#{answer.question.id}"
    else
      redirect to "/questions/#{answer.question.id}"
    end
  end

  delete '/answers/:id/likes' do
    answer = Answer.find_by_id(params[:id])
    like_answer = answer.likes.find_by(user:current_user)
    if like_answer
      like_answer.delete
      redirect to "/questions/#{answer.question.id}"
    else
      redirect to "/questions/#{answer.question.id}"
    end
  end
end
