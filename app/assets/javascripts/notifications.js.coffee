class Notifications
  constructor: ->
    @notifications = $("[data-behavior='notifications']")
    @setup() if @notifications.length > 0
    
  setup: ->
    $("[data-behavior='notifications-link']").on "click", @handleClick
    $.ajax(
      url: "/notifications.json"
      dataType: "JSON"
      method: "GET"
      success: @handleSuccess
    )
  
  handleClick: (e) =>
    $.ajax(
      url: "/notifications/mark_as_read"
      dataType: "JSON"
      method: "POST"
      success: =>
        $("[data-behavior='unread-count']").html("")  
    )
  
  handleSuccess: (data) =>
    items = $.map data, (notification) ->
      "<li><a href='root_path'>#{notification.actor} #{notification.action} #{notification.notifiable.type} for you</a></li>"
    $("[data-behavior='notification-items']").html(items)  
    if items.length > 0 then $("[data-behavior='unread-count']").html("<span class='label label-danger'>#{items.length}</span>")
    if imems.length == 0 then $("[data-behavior='unread-count']").html("")
    
jQuery ->
  new Notifications