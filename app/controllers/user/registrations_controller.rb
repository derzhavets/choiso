class User::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters
  
  def after_inactive_sign_up_path_for(resource)
    root_path
  end
  
  def after_sign_up_path_for(resource)
    root_path
  end
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:first_name, :last_name)
    devise_parameter_sanitizer.for(:account_update).push(:first_name, :last_name)
  end
end