class CriticalPointsController < ApplicationController
  before_filter :require_alternatives_and_mirror
  
  def index
    if params[:proposer_id]
      @user = User.find(params[:proposer_id])
    else
      @user = current_user
    end
    
    user_session.set_showable("critical_points")
    user_session.set_exampleable("basic")
    
    @traits = ["strengths","weaknesses"]
  end
  
  def create
    @critical_point = CriticalPoint.new(critical_point_params)
    @critical_point.user = @critical_point.alternative.user
    
    @critical_point.save unless @critical_point.already_exists?
    
    #Create notification
    Notification.generate("proposed", @critical_point) unless @critical_point.user == current_user
    
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    @critical_point = CriticalPoint.find(params[:id])
    @alternative = Alternative.find(@critical_point.alternative_id)
    @user = @alternative.user
    @critical_point.destroy
    @traits = ["Strength","Weakness"]
    
    respond_to do |format|
      format.js
    end
  end
  
  private
  
  def critical_point_params
    params.require(:critical_point).permit(:alternative_id, :point_type, :point_id, :proposer_id)
  end
  
  def require_alternatives_and_mirror
    if current_user.own_alternatives.count == 0
      flash[:danger] = "Please state at least one alternative to start working with Critical points"
      redirect_to alternatives_path
    elsif current_user.traits_count == 0
      flash[:danger] = "Please state at least couple of traits to start working with Critical points"
      redirect_to traits_path
    end
  end
end