json.array! @notifications do |notification|
  json.url notification_link_for(notification)
  json.data_behavior notification_data_behavior_for(notification)
  json.actor notification.actor.full_name
  json.action notification.action
  json.notifiable do
    json.type "#{notification.notifiable_type.downcase}"
  end
end