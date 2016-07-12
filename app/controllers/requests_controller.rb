class RequestsController < ApplicationController
  before_action :authenticate_user!
    
    def index
      respond_to do |format|
        format.js
      end
    end
    
    
    def create
      params[:friend_ids].each do |friend_id|
        @request = Request.new(request_params)
        @request.send_to(friend_id)
      
        #Create notification
        Notification.generate("asked", @request)
      end
      
      respond_to do |format|
        format.js { flash.now[:success] = "Request was successfully submitted" }
      end      
    end
  
  
  private
  
  def request_params
    params.require(:request).permit(:sender_id, :collectible_id, :collectible_type, :evaluable_id, :evaluable_type)
  end
    
end