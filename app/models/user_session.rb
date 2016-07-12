class UserSession
  def initialize(session)
    @session = session
    @session[:comment_ids] ||= []
  end
  
  # Show proposals section
  
  def set_proposer(proposer_id)
    @session[:proposer_id] = proposer_id if proposer_id
  end
    
  def set_showable(showable)
    @session[:showable] = showable if showable
  end
    
  def set_exampleable(exampleable)
    @session[:exampleable_type] = exampleable if exampleable
  end
  
  def proposer
    User.find(@session[:proposer_id])
  end
  
  def showable
    @session[:showable]
  end
  
  def exampleable
    @session[:exampleable_type]
  end
  
  def collectible
    @session[:showable].singularize.capitalize.constantize.first
  end
end