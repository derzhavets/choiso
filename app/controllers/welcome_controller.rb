class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:start]
  
  def start
  end
  
  def home
    @alternatives = current_user.alternatives.where(proposer_id: current_user.id)
    @proposer = User.find(11)
  end
end