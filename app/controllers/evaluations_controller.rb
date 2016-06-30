class EvaluationsController < ApplicationController
  def create
    Evaluation.create(rateable: Alternative.find(evaluation_params[:rateable_id]),
                                  rater: User.find(evaluation_params[:rater_id]), 
                                  score: evaluation_params[:score])
    
    respond_to do |format|
      format.js
    end
  end
  
  def update
    Evaluation.create(rateable: Alternative.find(evaluation_params[:rateable_id]),
                                  rater: User.find(evaluation_params[:rater_id]), 
                                  score: evaluation_params[:score])
    respond_to do |format|
      format.js
    end
  end
  
  private
  
  def evaluation_params
    params.require(:evaluation).permit(:rateable_id, :rater_id, :score)
  end
end