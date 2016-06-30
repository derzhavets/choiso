class Evaluations

  set_values = (form_id, value) ->
    i = 1
    while i <= 3
      if i <= value
        $('#' + form_id + '_' + i).addClass 'label-success'
      else
        $('#' + form_id + '_' + i).removeClass 'label-success'
      i++
    return

  $ ->
    $('.rating_score').hover ->
      form_id = $(this).attr('data-form-id')
      value = $(this).attr('data-value')
      set_values form_id, value
      
    $('.rating_score').mouseout ->
      $('.evaluation_form').each ->
        form_id = $(this).attr('id')
        set_values form_id, $('#' + form_id + '_score').val()
      
    $('.rating_score').click ->
      score = $(this)
      form_id = score.attr('data-form-id')
      value = score.attr('data-value')
      $('#' + form_id + '_score').val value
      
      $.ajax
        type: 'post'
        url: $('#' + form_id).attr('action')
        data: $('#' + form_id).serialize()
      
    $('.evaluation_form').each ->
      form_id = $(this).attr('id')
      set_values form_id, $('#' + form_id + '_score').val()


jQuery ->
  new Evaluations

