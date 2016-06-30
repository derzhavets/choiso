json.title @proposal.title
json.dropdown render partial: "proposals/templates/dropdown", locals: { proposal: @proposal }, formats: [:html]
json.proposals render partial: "proposals/templates/#{@proposal.showable.underscore}", locals: { proposal: @proposal }, formats: [:html]