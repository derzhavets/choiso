class WeaknessesController < ApplicationController
    before_action :set_weakness, only: [:destroy]
  
  def create
    @weakness = Weakness.new(weakness_params)
    @weakness.user = User.find(params[:user_id])
    @weakness.proposer = current_user

    respond_to do |format|
      if @weakness.save
        
        #Create notification
        if @weakness.user != current_user
          @notification = Notification.new(recipient: @weakness.user, actor: current_user, 
                              notifiable: @weakness, action: "proposed")
          @notification.save if @notification.relevant?                  
        end
        
        format.js
        format.html { render alternatives_path }
      else
        format.json { render json: @weakness.errors, status: :unprocessable_entity }
        format.html { redirect_to mirror_path, flash[:danger] = @weakness.errors }
      end
    end
  end
  
  def destroy
    @weakness.destroy
    respond_to do |format|
      format.html { redirect_to alternatives_url, notice: 'Weakness was successfully deleted.' }
      format.js
    end
  end
  
  private
  
  def set_weakness
    @weakness = Weakness.find(params[:id])
  end
  
  def weakness_params
    params.require(:weakness).permit(:name, :proposer_id, :user_id)
  end
  
end