class AnalysisController < AdminBaseController


  def index
    gon.mail_user_size = User.where(provider: nil, states_cd: User.states[:normal]).size
    gon.twitter_user_size = User.where(provider: "twitter", states_cd: User.states[:normal]).size

    gon.notice_user_size = User.normals.select{|u| u.is_send_email}.size
    gon.unnotice_user_size = User.normals.select{|u| !u.is_send_email}.size

    tt = Time.current
    @t = Time.new(tt.year, tt.month, tt.day, 0, 0, 0)

    logs_array =  [0,1,2,3,4,5,6,7].map{ |n|
      ActionLog.includes(:user).where(request_method: "GET", created_at: @t.ago((n+1).days)..@t.ago(n.days)).select{|l| l.user.blank? || l.user.normal?}
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


end
