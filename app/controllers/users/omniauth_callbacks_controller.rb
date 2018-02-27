# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
  def twitter
      # auth = request.env["omniauth.auth"]["extra"]["access_token"]
      # session[:access_token] = auth.token
      # session[:access_token_secret] = auth.secret
      auth = request.env['omniauth.auth']
      at = auth["extra"]["access_token"]
      session[:access_token] = auth['credentials']['token']
      session[:access_token_secret] = auth['credentials']['secret']
      #session[:auth] = auth
      @user = User.from_omniauth(request.env["omniauth.auth"].except("extra"))
      if @user.persisted?
          flash[:notice] = "ログインしました"
          sign_in_and_redirect @user, notice: 'ログインしました'
          #after_sign_in_path_for @user
      else
          session["devise.user_attributes"] = @user.attributes
          flash[:notice] = "登録が完了しました"
          #redirect_to new_user_registration_url
          #redirect_to new_question_url
          #after_sign_in_path_for @user
      end
  end

end
