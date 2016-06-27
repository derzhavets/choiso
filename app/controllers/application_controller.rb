class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :require_login
  helper_method :link_to_show_proposal, :notification_link_for, 
                :notification_data_behavior_for,
                :list_for, :link_to_show_examples_of, 
                :link_to_change_proposal, :style_for,
                :display_name_for, :user_session
  
  def link_to_show_proposal(showable, proposer_id)
    return "/show_proposals?proposer_id=#{proposer_id}&showable=#{showable}"
  end
  
  def link_to_show_examples_of(showable, type)
    return "/show_proposals?proposer_id=#{User.choiso_account_id}&showable=#{showable}&exampleable_type=#{type}"
  end
  
  def link_to_change_proposal(showable)
    return "/show_proposals?showable=#{showable}"
  end
  
  def display_name_for(user)
    if user == current_user
      "your"
    else
      "#{user.first_name}'s"
    end
  end
  

  
  def style_for(trait)
    return "btn-success" if trait.class == "Strength"
    return "btn-danger" if trait.class == "Weakness"
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
