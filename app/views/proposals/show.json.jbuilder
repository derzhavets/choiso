json.exampleable_types do
  json.array! @exampleable_types do |type|
    json.name type.capitalize
  end
end

json.proposers do
  json.array! @proposers do |proposer|
    json.name proposer.full_name
    json.url link_to_show_proposal(@showable, proposer.id)
  end
end

json.proposal_name @proposal_name

json.proposals do
  json.array! @proposals do |proposal|
      json.name proposal.name.capitalize
  end
end