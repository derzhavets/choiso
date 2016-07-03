class EvaluationsController < ApplicationController
  def create
    Evaluation.create(rateable: params[:showable].constantize.find(evaluation_params[:rateable_id]),
                                  rater: current_user, 
                                  score: evaluation_params[:score])
    
    respond_to do |format|
      format.js
    end
  end
  
  def update
    Evaluation.create(rateable: params[:showable].constantize.find(evaluation_params[:rateable_id]),
                                  rater: current_user, 
                                  score: evaluation_params[:score])
    respond_to do |format|
      format.js
    end
  end
  
  private
  
  def evaluation_params
    params.require(:evaluation).permit(:rateable_id, :score, :showable)
  end
end