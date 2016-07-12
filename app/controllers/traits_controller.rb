class TraitsController < ApplicationController
  before_action :set_trait, only: [:destroy]
  
  def index
    @user = current_user
    user_session.set_showable("strengths")
    @resources = ["Strength", "Weakness"]
  end
  
  def create
    @trait = Trait.new(trait_params)
    
    respond_to do |format|
      if @trait.save
        #Create notification
        Notification.generate("proposed", @trait) if @trait.user != current_user
        
        format.js
      else
        format.js { flash.now[:danger] = @trait.errors.full_messages.first }
      end
    end
  end
  
  def destroy
    @trait.destroy
  end
  
  private
  
  def set_trait
    @trait = params[:resource_name].constantize.find(params[:id])
  end
  
  def trait_params
    params.require(:trait).permit(:resource_name, :name, :user_id, :proposer_id)
  end
end