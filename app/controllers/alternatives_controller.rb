class AlternativesController < ApplicationController
  before_action :set_alternative, only: [:show, :edit, :update, :destroy]
  
  def index
    user_session.set_showable("alternatives")
    @user = current_user
  end

  def create
    @alternative = Alternative.new(alternative_params)
    
    respond_to do |format|
      if @alternative.save
        
        #Generate default rank
        @alternative.generate_rank if @alternative.user == current_user
        
        #Create notification
        Notification.generate("proposed", @alternative) if @alternative.user != current_user

        format.js
      else
        format.js { flash.now[:danger] = @alternative.errors.full_messages.first }
      end
    end
  end

  def destroy
    @alternative.destroy
    respond_to do |format|
      format.js
    end
  end

  private
    def set_alternative
      @alternative = Alternative.find(params[:id])
    end

    def alternative_params
      params.require(:alternative).permit(:name, :user_id, :proposer_id)
    end
end
