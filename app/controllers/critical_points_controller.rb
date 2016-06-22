class CriticalPointsController < ApplicationController
  def index
    @traits = ["strengths","weaknesses"]
  end
  
  def create
    @critical_point = CriticalPoint.new(alternative_id: params[:alternative_id], point_type: params[:point_type], point_id: params[:point_id])
    @alternative = Alternative.find(@critical_point.alternative_id)
    
    if @critical_point.save
      respond_to do |format|
        #format.html { redirect_to critical_points_path }
        format.js
      end
    end
  end
  
  def destroy
    @critical_point = CriticalPoint.find(params[:id])
    @alternative = Alternative.find(@critical_point.alternative_id)
    @critical_point.destroy
    @traits = ["Strength","Weakness"]
    
    respond_to do |format|
      format.js
    end
  end
end