class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:start]
  
  def start
  end
  
  def home
    @alternatives = current_user.alternatives.where(proposer_id: current_user.id)
    
    #Default: showing basic alternatives examples
    @proposer = User.find(15)
    @examples = Example.where("exampleable_type = ? AND exampleable = ?", "basic", "alternatives")
  end
end