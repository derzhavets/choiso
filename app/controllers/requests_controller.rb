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
        
        collectible_type = session[:showable].singularize if params[:collectible_type]
        
        @request = Request.new(sender: current_user, receiver: receiver, evaluable: evaluable, collectible_type: collectible_type)
        @request.save unless @request.already_exists?  
        
        #Create notification
        #Notification.create(recipient: receiver, actor: current_user, 
        #                        notifiable: "#{collectible_type}".singularize.capitalize.constantize.first, action: "asked")
      end
      
    
      respond_to do |format|
        format.js { flash.now[:success] = "Request was successfully submitted" }
        #format.html { redirect_to root_path, notice: 'Request was successfully created.' }
      end      
    end
end