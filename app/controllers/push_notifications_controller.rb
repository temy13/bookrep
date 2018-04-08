class PushNotificationsController < ApplicationController
  def create
    return if current_user.blank?
    return if current_user.push_notification.present?
    PushNotification.create(user_id:current_user.id, firebase_token: params[:token])
    #return if params["subscription"].blank?
    #data = params["subscription"]
    #PushNotification.create(user_id:current_user.id, endpoint:data["endpoint"], p256dh:data["keys"]["p256dh"], auth:data["keys"]["auth"] )
    head :ok
  end
end
