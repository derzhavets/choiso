class StrengthsController < ApplicationController
    before_action :set_strength, only: [:destroy]
  
  def create
    @strength = Strength.new(strength_params)
    @strength.user = User.find(params[:user_id])
    @strength.proposer = current_user

    respond_to do |format|
      if @strength.save
        
        #Create notification
        if @strength.user != current_user
          Notification.create(recipient: @alternative.user, actor: current_user, 
                              notifiable: @alternative, action: "proposed")
        end
        
        format.js
        format.html { render alternatives_path }
      else
        format.json { render json: @strength.errors, status: :unprocessable_entity }
        format.html { redirect_to mirror_path, flash[:danger] = @strength.errors }
      end
    end
  end
  
  def destroy
    @strength.destroy
    respond_to do |format|
      format.html { redirect_to alternatives_url, notice: 'Strength was successfully deleted.' }
      format.js
    end
  end
  
  private
  
  def set_strength
    @strength = Strength.find(params[:id])
  end
  
  def strength_params
    params.require(:strength).permit(:name, :proposer_id, :user_id)
  end
  
end