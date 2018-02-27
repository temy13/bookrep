class ProfileController < ApplicationController
  PER = 10
  def show
    @user = User.find(params[:id])
    if @user == current_user
      @questions = Question.user_questions(@user.id).page(params[:page_q]).per(PER)
      @answer_questions = Question.user_answered(@user.id).page(params[:page_a]).per(PER)
    else
      @questions = Question.user_questions_remove_anonymous(@user.id).page(params[:page_q]).per(PER)
      @answer_questions = Question.user_answered_remove_anonymous(@user.id).page(params[:page_a]).per(PER)
    end
  end
end
