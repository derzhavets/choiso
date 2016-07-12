module UsersHelper
  def folder_name_for(resource)
    case resource
      when "Strength", "Weakness"
        "traits"
      else
        resource.downcase.pluralize
    end
  end
end