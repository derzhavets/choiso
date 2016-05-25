json.array! @notifications do |notification|
  #json.id notification.id
  
  json.actor notification.actor.full_name
  json.action notification.action
  json.notifiable do
    json.type "#{notification.notifiable_type.downcase}"
  end
end