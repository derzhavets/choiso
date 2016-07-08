class Proposals

  constructor: ->
    @proposals = $("[data-behavior='proposals']")
    @setup() if @proposals.length > 0

  setup: ->
    $(document).on 'click', "[data-behavior='toggle-proposals']", (event) =>
      $('#proposals-body').slideToggle 'fast'
      $('#toggle-proposals-label').html("Do" ? "Not" : "Do")
    
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
    $("[data-behavior='proposals-dropdown']").html(data.dropdown)
    $("[data-behavior='proposal-title']").html(data.title)
    $("[data-behavior='proposal-list']").html(data.proposals)
  );
  
jQuery ->
  new Proposals



