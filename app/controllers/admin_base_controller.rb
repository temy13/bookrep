class AdminBaseController < ApplicationController
  before_action :check_admin

  private
  def check_admin
    raise ActionController::RoutingError.new('Not Found') unless current_user.present? && current_user.admin?
    basic
  end

  def basic
      authenticate_or_request_with_http_basic do |user, pass|
        user == 'user' && pass == 'admin'
      end
  end

end
