class CriticalPointsController < ApplicationController
  def index
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    
    @traits = ["strengths","weaknesses"]
  end
  
  def create
    @critical_point = CriticalPoint.new(alternative_id: params[:alternative_id], point_type: params[:point_type], point_id: params[:point_id], proposer_id: params[:proposer_id])
    @alternative = Alternative.find(@critical_point.alternative_id)
    @user = @alternative.user
    
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