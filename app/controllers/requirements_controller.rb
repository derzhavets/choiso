class RequirementsController < ApplicationController
  before_action :set_requirement, only: [:show, :edit, :update, :destroy]
  
  def index
    if params[:proposer_id]
      @user = User.find(params[:proposer_id])
    else
      @user = current_user
    end
    
    session[:showable] = "requirements"
    session[:exampleable_type] = "basic"
    
  end
  
  def create
    @requirement = Requirement.new(requirement_params)
    @requirement.user = User.find(params[:user_id])
    @requirement.proposer = current_user
    @requirement.alternative = Alternative.find(params[:alternative_id])

    respond_to do |format|
      if @requirement.save
        
        #Create notification
        if @requirement.user != current_user
          @notification = Notification.new(recipient: @requirement.user, actor: current_user, 
                              notifiable: @requirement, action: "proposed")
          @notification.save if @notification.relevant?                  
        end
        
        format.js
      else
        format.json { render json: @requirement.errors, status: :unprocessable_entity }
        format.html { redirect_to requirements_path, flash[:danger] = @requirement.errors }
      end
    end
  end
  
  def destroy
    @requirement.destroy
    respond_to do |format|
      format.html { redirect_to alternatives_url, notice: 'Requirement was successfully deleted.' }
      format.js
    end
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_requirement
    @requirement = Requirement.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def requirement_params
    params.require(:requirement).permit(:name, :proposer_id, :user_id)
  end
  
end