json.array! @notifications do |notification|
  json.unread !notification.read_at?
  json.template render partial: "notifications/#{notification.action.underscore}", locals: {notification: notification}, formats: [:html]
end