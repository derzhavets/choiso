module ProposalsHelper
  def link_to_show_proposal(showable, proposer_id)
    "/show_proposals?proposer_id=#{proposer_id}&showable=#{showable}"
  end
  
  def link_to_show_examples_of(showable, type)
    "/show_proposals?proposer_id=#{User.choiso_account_id}&showable=#{showable}&exampleable_type=#{type}"
  end
  
  def link_to_change_proposal(showable)
    "/show_proposals?showable=#{showable.downcase.pluralize}"
  end
end