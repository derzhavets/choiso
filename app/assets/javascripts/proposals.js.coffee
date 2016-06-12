class Proposals

  constructor: ->
    @proposals = $("[data-behavior='proposals']")
    @setup() if @proposals.length > 0
    

  setup: ->
    $(document).on 'click', "[data-behavior='proposal-link']", (event) -> (
      event.preventDefault()
      link = $(this).data("url")
      $.ajax(
        url: link
        dataType: "JSON"
        method: "GET"
        success: alert link
      )
    );
    
    $.ajax(
      url: "/show_proposals"
      dataType: "JSON"
      method: "GET"
      success: @showProposals
    );

  showProposals: (data) => (
    alert "Fuck"
    $("[data-behavior='show-proposers']").html("<li><a href='root_path'><strong>Examples by Choiso</strong></a></li>")
    types = $.map data.exampleable_types, (type) ->
      "<li><a href='root_path'>#{type.name} examples</a></li>"
    $("[data-behavior='show-proposers']").append(types)
    $("[data-behavior='show-proposers']").append("<li><a href='root_path'><strong>Proposals by users</strong></a></li>")
    
    proposers = $.map data.proposers, (proposer) ->
      "<li><a href='#' data-url='#{proposer.url}' data-behavior='proposal-link' class='proposal-link'>#{proposer.name}</a></li>"
    $("[data-behavior='show-proposers']").append(proposers)
    $("[data-behavior='show-proposal-name']").html(data.proposal_name)
    proposals = $.map data.proposals, (proposal) ->
      "<tr><td>#{proposal.name}</td></tr>"
    $("[data-behavior='show-proposals']").html(proposals)
  );
  
jQuery ->
  new Proposals



