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
          evaluable_id = evaluable.id
        else
          evaluable = nil
          evaluable_id = nil
        end
      
        collectible_type = params[:collectible_type] if params[:collectible_type]
        @request = Request.new(sender: current_user, receiver: receiver, evaluable: evaluable, collectible_type: collectible_type) unless Request.exists?(:receiver_id => receiver.id, :sender_id => current_user.id, :evaluable_id => evaluable_id, :collectible_type => collectible_type)
        
        if @request.save
          #Create notification
            Notification.create(recipient: receiver, actor: current_user, 
                                notifiable: current_user.alternatives.first, action: "asked for")
        end
      end
      

      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Request was successfully created.' }
      end      
    end
end