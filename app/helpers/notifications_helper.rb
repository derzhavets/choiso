module NotificationsHelper
    
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
  
end