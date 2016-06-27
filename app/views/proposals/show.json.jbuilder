json.title @proposal.title
json.dropdown render partial: "proposals/common/dropdown", locals: { proposal: @proposal }, formats: [:html]
json.proposals render partial: "proposals/common/#{@proposal.showable.underscore}", locals: { proposal: @proposal }, formats: [:html]