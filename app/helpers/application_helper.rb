module ApplicationHelper
  
  def gravatar_for(user, options = { size: 80})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.full_name, class: "img-circle")
  end

  def bootstrap_class_for flash_type
    { success: "success", error: "error", alert: "warning", notice: "info" }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert alert-#{bootstrap_class_for(msg_type)} fade in") do 
              concat content_tag(:button, '×'.html_safe, class: "close", data: { dismiss: 'alert' })
              concat message 
            end)
    end
    nil
  end  
end
