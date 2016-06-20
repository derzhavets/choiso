class ProposalsController < ApplicationController
  def show
    if params[:showable]
      @showable = params[:showable]
    else
      @showable = session[:showable]
    end
    
    @proposers = current_user.proposers_of(@showable)
    @exampleable_types = Example.types_of(@showable)
    session[:proposer_id] = params[:proposer_id] if params[:proposer_id]
    
    if session[:proposer_id] == choiso_account_id
      if params[:exampleable_type]
        @type = params[:exampleable_type]
      else
        @type = session[:exampleable_type]
      end
      
      @proposal_name = "#{@type.capitalize} #{@showable} examples by Choiso"
      @proposals = Example.for_showable_type(@showable, @type)
    else
      @proposer = User.find(session[:proposer_id])
      @proposal_name = "#{@showable.capitalize} proposals by #{@proposer.full_name}"
      @proposals = current_user.proposals_for(@showable, @proposer)
    end
    
    session[:showable] = @showable
  end
end