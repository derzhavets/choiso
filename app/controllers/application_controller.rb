class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :authenticate_user!
  
  helper_method :link_to_show_proposal, :notification_link_for, :notification_data_behavior_for, :choiso_account_id
  
  def link_to_show_proposal(showable, proposer_id)
    return "/show_proposals?proposer_id=#{proposer_id}&showable=#{showable}"
  end
  
  def notification_link_for(notification)
    if notification.action == "proposed"
      return link_to_show_proposal("#{notification.notifiable_type.downcase.pluralize}", notification.actor_id)  
    else
      return "/users/#{notification.actor_id}"
    end
  end
  
  def notification_data_behavior_for(notification)
    if notification.action == "proposed"
      return "proposal-link"   
    else
      return nil
    end
  end
  
  def choiso_account_id
    return User.where(first_name: "choiso").first.id
  end
end
