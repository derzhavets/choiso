class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :require_login
  helper_method :style_for, :user_session
  
  def style_for(trait)
    return "btn-success" if trait.class == "Strength"
    return "btn-danger" if trait.class == "Weakness"
  end
  
  private
  
  def user_session
    @user_session ||= UserSession.new(session)
  end
  
  def require_login
    unless current_user
      redirect_to welcome_path
    end
  end
end
