class RequestsController < ApplicationController
  before_action :authenticate_user!
    
    def index
    end
    
    
    def create
      @receivers = params[:friend_ids]
      @receivers.each do |friend_id|
        receiver = User.find(friend_id)
        
        if params[:evaluable_type]
          evaluable = Alternative.find(params[:evaluable_id]) if params[:evaluable_type] == "Alternative"
        else
          evaluable = nil
        end
      
        collectible_type = params[:collectible_type] if params[:collectible_type]
        Request.create(sender: current_user, receiver: receiver, evaluable: evaluable, collectible_type: collectible_type)
      end
      

      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Request was successfully created.' }
      end      
    end
end