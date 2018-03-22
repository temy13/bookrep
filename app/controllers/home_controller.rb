class HomeController < ApplicationController
  def index
    # redirect_to controller: 'questions', action: 'new' if user_signed_in?
    redirect_to controller: 'questions', action: 'index' if user_signed_in?
  end

  def policy
  end

  def terms
  end

end
