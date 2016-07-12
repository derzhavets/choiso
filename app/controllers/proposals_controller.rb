class ProposalsController < ApplicationController
  def show
    user_session.set_proposer(params[:proposer_id])
    user_session.set_showable(params[:showable])
    user_session.set_exampleable(params[:exampleable_type])
    
    @proposal = Proposal.new(proposer: user_session.proposer, user: current_user, 
                             showable: user_session.showable, exampleable_type: user_session.exampleable)
  end
end