class AlternativesController < ApplicationController
  before_action :set_alternative, only: [:show, :edit, :update, :destroy]
  
  def index
    session[:showable] = "alternatives"
    session[:exampleable_type] = "basic"
    @alternatives = current_user.own_alternatives
    @user = current_user
    session[:show_help] = true
  end

  def create
    @alternative = Alternative.new(alternative_params)
    @alternative.user = User.find(params[:user_id])
    @alternative.proposer = current_user
    
    respond_to do |format|
      if @alternative.save
        
        #Create notification
        if @alternative.user != current_user
          @notification = Notification.new(recipient: @alternative.user, actor: current_user, 
                              notifiable: @alternative, action: "proposed")
          @notification.save if @notification.relevant?                  
        end
        
        format.js
      else
        format.js { flash.now[:danger] = @alternative.errors.full_messages.first }
      end
    end
  end

  def destroy
    @alternative.destroy
    respond_to do |format|
      format.html { redirect_to alternatives_url, notice: 'Alternative was successfully deleted.' }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alternative
      @alternative = Alternative.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alternative_params
      params.require(:alternative).permit(:name, :user_id)
    end
end
