json.exampleable_types do
  json.array! @exampleable_types do |type|
    json.name type.capitalize
    json.url link_to_show_examples_of(@showable, type)
  end
end

json.proposers do
  json.array! @proposers do |proposer|
    json.name proposer.full_name
    json.url link_to_show_proposal(@showable, proposer.id)
  end
end

json.proposal do
  json.showable @showable
  json.title @proposal_name
end

json.proposals do
  json.array! @proposals do |proposal|
      json.name proposal.name.capitalize
  end
end