class CriticalPointsController < ApplicationController
  def index
  end
  
  def create
    params[:point_ids].each do |id|
      point = params[:point_type].constantize.find(id)
      CriticalPoint.create(alternative_id: params[:alternative_id], point: point)
    end
    
    respond_to do |format|
      format.html { redirect_to critical_points_path }
    end
  end
  
  def destroy
    @critical_point = CriticalPoint.find(params[:id])
    @critical_point.destroy
    
    respond_to do |format|
      format.html { redirect_to critical_points_path }
    end
  end
  
end