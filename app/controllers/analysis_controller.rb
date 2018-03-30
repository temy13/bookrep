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
    logs_array.unshift(ActionLog.includes(:user).where(request_method: "GET", created_at: @t..tt).select{|l| l.user.blank? || l.user.normal?})
    remote_ips_array = logs_array.map{|logs| logs
        .map{|log| log.remote_ip}
    }
    users_array = logs_array.map{|logs| logs
        .select{ |log| log.user.present?}
        .map{|log| log.user_id }
      }

    gon.all_get_numbers = logs_array.map{|logs|
      logs.size
    }
    gon.unique_ips = remote_ips_array.map{|remote_ips|
        remote_ips.uniq.size
    }
    gon.unique_users = users_array.map{|users|
        users.uniq.size
    }
    gon.ips_d_rate = remote_ips_array.map{|remote_ips|
        remote_ips.size == 0 ? 0 : (remote_ips.select{|remote_ip| remote_ips.count(remote_ip) == 1}.size.to_f / remote_ips.size) * 100.0
    }
    gon.users_d_rate = users_array.map{|users|
        users.size == 0 ? 0 : (users.select{|user| users.count(user) == 1}.size.to_f / users.size) * 100.0
    }

  end


end
