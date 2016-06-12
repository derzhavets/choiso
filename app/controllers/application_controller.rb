class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  
  helper_method :link_to_show_proposal
  
  def link_to_show_proposal(showable, proposer_id)
    return "/show_proposals?proposer_id=#{proposer_id}&showable=#{showable}"
  end
  
end
