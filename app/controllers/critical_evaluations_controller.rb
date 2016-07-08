class CriticalEvaluationsController < ApplicationController
  def create
    @alternative = Alternative.find(critical_evaluation_params[:alternative_id])
    @critical_evaluation = CriticalEvaluation.new(alternative: @alternative, rater: current_user, score: critical_evaluation_params[:score])
    @critical_points = @alternative.critical_points.proposed_by(current_user).map { |cp| cp.id }
    @critical_evaluation.critical_points = @critical_points
    
    @critical_evaluation.save
    
    respond_to do |format|
      format.js
    end
  end
  
  def update
    @alternative = Alternative.find(critical_evaluation_params[:alternative_id])
    @critical_evaluation = CriticalEvaluation.new(alternative: @alternative, rater: current_user, score: critical_evaluation_params[:score])
    @critical_points = @alternative.critical_points.proposed_by(current_user).map { |cp| cp.id }
    @critical_evaluation.critical_points = @critical_points
    
    @critical_evaluation.save
    
    respond_to do |format|
      format.js
    end
  end
  
  private
  
  def critical_evaluation_params
    params.require(:critical_evaluation).permit(:alternative_id, :score)
  end
end