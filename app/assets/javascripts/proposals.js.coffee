class Proposals

  constructor: ->
    @proposals = $("[data-behavior='proposals']")
    @setup() if @proposals.length > 0
    

  setup: ->
    $(document).on 'click', "[data-behavior='proposal-link']", (event) => (
      event.preventDefault()
      link = $(event.target).data("url")
      $.ajax(
        url: link
        dataType: "JSON"
        method: "GET"
        success: @showProposals
      )
    );
    
    $.ajax(
      url: "/show_proposals"
      dataType: "JSON"
      method: "GET"
      success: @showProposals
    );
  
  showProposals: (data) => (
    $("[data-behavior='show-proposers']").html("<li><a href='root_path'><strong>Examples by Choiso</strong></a></li>")
    types = $.map data.exampleable_types, (type) ->
      "<li><a href='#' data-behavior='proposal-link' data-url='#{type.url}'>#{type.name} examples</a></li>"
    $("[data-behavior='show-proposers']").append(types)
    
    $("[data-behavior='show-proposers']").append("<li><a href='root_path'><strong>Proposals by users</strong></a></li>")
    
    proposers = $.map data.proposers, (proposer) ->
      "<li><a href='#' data-behavior='proposal-link' data-url='#{proposer.url}'>#{proposer.name}</a></li>"
    $("[data-behavior='show-proposers']").append(proposers)
    
    $("[data-behavior='show-proposal-name']").html(data.proposal.title)
    $("#request-topic").html(data.proposal.showable)
    
    proposals = $.map data.proposals, (proposal) ->
      "<tr><td>#{proposal.name}</td></tr>"
    $("[data-behavior='show-proposals']").html(proposals)
    
    
  );
  
jQuery ->
  new Proposals



