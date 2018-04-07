class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :create_action_log
  after_action :store_location
  helper_method :vapid_public_key

  def vapid_public_key
    @decoded_vapid_public_key ||= Base64.urlsafe_decode64(ENV['VAPID_PUBLIC_KEY']).bytes
  end

  def append_info_to_payload(payload)
    super
    payload[:host] = request.host
    payload[:ip] = request.ip
    remote_ip = request.env["HTTP_X_FORWARDED_FOR"] || request.remote_ip
    payload[:remote_ip] = remote_ip
    payload[:referer] = request.referer
    payload[:user_agent] = request.user_agent

    payload[:login_id] = current_user.try(:id)#session[:login_id]
  end

  def store_location
   # 今回の場合は、 /users/sign_in , /users/sign_up, /users/password にアクセスしたとき、ajaxでのやりとりはsessionには保存しない。
    if check_except
      session[:previous_url] = request.fullpath
    end
  end

  #ログイン後のリダイレクトをログイン前のページにする場合
  def after_sign_in_path_for(resource)
    check_except ? (session[:previous_url] || questions_path) : questions_path
  end

  #ログアウト後のリダイレクトをログアウト前のページにする場合
  def after_sign_out_path_for(resource)
    session[:previous_url] || root_path
  end

  def after_sign_up_path_for(resource)
    check_except ? (session[:previous_url] || questions_path) : questions_path
  end

  def after_inactive_sign_up_path_for(resource)
    check_except ? (session[:previous_url] || questions_path) : questions_path
  end


  # 例外ハンドル
  unless Rails.env.development?
    rescue_from Exception,                        with: :_render_500
    rescue_from ActiveRecord::RecordNotFound,     with: :_render_404
    rescue_from ActionController::RoutingError,   with: :_render_404
  end

  def routing_error
    raise ActionController::RoutingError, params[:path]
  end

  private

  def create_action_log
    remote_ip = request.env["HTTP_X_FORWARDED_FOR"] || request.remote_ip
    log = ActionLog.new(
      user: current_user,
      request_method: request.request_method,
      path_info: request.path_info,
      ip: request.ip,
      remote_ip: remote_ip
    )
    log.save
  end

  def check_except
    return (request.path_info != "/users/sign_in" && \
        request.path_info != "/users/sign_up" && \
        request.path_info != "/users/password" && \
        request.path_info != "/users/login" && \
        request.path_info != "/users/logout" && \
        !request.xhr?)
  end

  def _render_404(e = nil)
    logger.info "Rendering 404 with exception: #{e.message}" if e
    if request.format.to_sym == :json
      render json: { error: '404 error' }, status: :not_found
    else
      render 'errors/404', status: :not_found
    end
  end

  def _render_500(e = nil)
    logger.error "Rendering 500 with exception: #{e.message}" if e
    #Airbrake.notify(e) if e # Airbrake/Errbitを使う場合はこちら
    if request.format.to_sym == :json
      render json: { error: '500 error' }, status: :internal_server_error
    else
      render 'errors/500', status: :internal_server_error
    end
  end

end
