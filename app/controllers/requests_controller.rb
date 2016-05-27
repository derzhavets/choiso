class RequestsController < ApplicationController
  before_action :authenticate_user!
    
    def index
    end
    
    
    def create
      
      receiver = User.find(params[:user_id])
      
      if params[:evaluable_type]
        evaluable = Alternative.find(params[:evaluable_id]) if params[:evaluable_type] == "Alternative"
      else
        evaluable = nil
      end
      
      collectible_type = nil unless params[:collectible_type]
      Request.create(sender: current_user, receiver: receiver, evaluable: evaluable, collectible_type: collectible_type)
    
      respond_to do |format|
        format.js { }
      end      
    end
end