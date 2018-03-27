# frozen_string_literal: true
require 'csv'

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end
  # POST /resource
  def create
    build_resource(sign_up_params)
    if resource.provider.blank? && resource.name == "クリス" #クリス is default name by DB
      names = CSV.read('db/namelist.csv')
      resource.name = names.sample.first
    end
    resource.is_email_notice = true
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      set_minimum_password_length
      response_to_sign_up_failure resource
    end
  end
  # GET /resource/edit
  def edit
    if resource.provider.present? && resource.is_dummy_email
      resource.email = nil
    end
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected
    def update_resource(resource, params)
      #resource.update_without_password(params)
      resource.update_with_password(params)
    end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  private
  def after_update_path_for(resource)
    profile_path(resource)
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :profile)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :name, :profile, :is_email_notice, :icon_path)
  end

  def response_to_sign_up_failure(resource)
    message = "エラーが発生しました"
    if resource.email == "" || resource.password == nil
      message =  "メールアドレスとパスワードは必須です"
    elsif User.pluck(:email).include? resource.email
      message =  "そのメールアドレスはすでに登録されています"
    end
    clean_up_passwords resource
    redirect_to root_path, alert: message, flash: { error: resource.errors.full_messages }
  end

end
