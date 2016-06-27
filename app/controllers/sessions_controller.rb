class SessionsController < Devise::SessionsController
  skip_before_action :require_login

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
    
    # Set default proposals
    user_session.set_proposer(User.choiso_account_id)
  end
  
end