class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # Check for Notifications at the start of the app
  before_action :get_notifications # only when logged in.. `current_user` variable should be there

  def get_notifications
  	
  	@notifs = []

  	if current_user
      @notifs = Notification.where(:user_id => current_user.id, :seen => false)
  	end
  end

end
