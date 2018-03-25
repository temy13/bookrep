class AnalysisController < ApplicationController

  before_action :check_admin

  def index
    gon.mail_user_size = User.where(provider: nil, states_cd: User.states[:normal]).size
    gon.twitter_user_size = User.where(provider: "twitter", states_cd: User.states[:normal]).size

    gon.notice_user_size = User.normals.select{|u| u.is_send_email}.size
    gon.unnotice_user_size = User.normals.select{|u| !u.is_send_email}.size

    t = Time.current
    logs_array =  [0,1,2,3,4,5,6,7].map{ |n|
      ActionLog.includes(:user).where(request_method: "GET", created_at: t.ago((n+1).days)..t.ago(n.days)).select{|l| l.user.blank? || l.user.normal?}
    }

    gon.all_get_numbers = logs_array.map{|logs| logs
      .size
    }
    gon.unique_ips = logs_array.map{|logs| logs
        .map{|log| log.remote_ip}
        .uniq.size
    }
    gon.unique_users = logs_array.map{|logs| logs
        .select{ |log| log.user.present?}
        .map{|log| log.user_id }
        .uniq.size
    }

  end

  private
  def check_admin
    return if current_user.present? && current_user.admin?
    raise ActionController::RoutingError.new('Not Found')
  end

end
