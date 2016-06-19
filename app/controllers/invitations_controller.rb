class InvitationsController < Devise::InvitationsController
  skip_before_action :require_login
  
  def after_accept_path_for(user)
    edit_user_registration_path(user)
  end
end