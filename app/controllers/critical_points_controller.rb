class CriticalPointsController < ApplicationController
  def index
    if params[:proposer_id]
      @user = User.find(params[:proposer_id])
    else
      @user = current_user
    end
    
    session[:showable] = "critical_points"
    session[:exampleable_type] = "basic"
    
    @traits = ["strengths","weaknesses"]
  end
  
  def create
    @alternative = Alternative.find(params[:alternative_id])
    @user = @alternative.user
    @critical_point = CriticalPoint.new(alternative_id: params[:alternative_id], point_type: params[:point_type], 
              point_id: params[:point_id], proposer_id: params[:proposer_id], user: @user)

    
    if @critical_point.save
      respond_to do |format|
        format.js
      end
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
end