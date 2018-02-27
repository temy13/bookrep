class HomeController < ApplicationController
  def index
    redirect_to controller: 'questions', action: 'new' if user_signed_in?
  end

  def policy
  end

  def terms
  end

end
