class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def require_user
    redirect_to new_user_session_path, notice: "Please sign in to continue" and return if !current_user
  end
end
