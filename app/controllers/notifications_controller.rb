class NotificationsController < ApplicationController
  before_action :logged_in_user, only: [:index, :create]
  
  # GET /notifications
  def index
    @notifications  = Notification.where("user_id = ?", current_user.id)
  end

end