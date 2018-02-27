class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  after_action :store_location

  def store_location
   # 今回の場合は、 /users/sign_in , /users/sign_up, /users/password にアクセスしたとき、ajaxでのやりとりはsessionには保存しない。
      if (request.fullpath != "/users/sign_in" && \
          request.fullpath != "/users/sign_up" && \
          request.fullpath != "/users/password" && \
          !request.xhr?) # don't store ajax calls
        session[:previous_url] = request.fullpath
      end
  end

  #ログイン後のリダイレクトをログイン前のページにする場合
  def after_sign_in_path_for(resource)
    session[:previous_url] || question_new_path
  end

  #ログアウト後のリダイレクトをログアウト前のページにする場合
  def after_sign_out_path_for(resource)
    session[:previous_url] || root_path
  end

  def after_sign_up_path_for(resource)
    session[:previous_url] || question_new_path
  end

  def after_inactive_sign_up_path_for(resource)
    session[:previous_url] || question_new_path
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
    Airbrake.notify(e) if e # Airbrake/Errbitを使う場合はこちら
    if request.format.to_sym == :json
      render json: { error: '500 error' }, status: :internal_server_error
    else
      render 'errors/500', status: :internal_server_error
    end
  end

end
