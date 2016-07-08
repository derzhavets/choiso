class Evaluations

  set_values = (form_id, value) ->
    max = $('#' + form_id).data('scale')
    label_class = $('#' + form_id).data('label-class')
    i = 1
    while i <= max
      if i <= value
        $('#' + form_id + '_' + i).addClass label_class
      else
        $('#' + form_id + '_' + i).removeClass label_class
      i++
    return
  
  $ ->
    $(document).on 'mouseenter', ".rating_score", (event) ->
      form_id = $(this).attr('data-form-id')
      value = $(this).attr('data-value')
      set_values form_id, value
      
    $(document).on 'mouseleave', ".rating_score", (event) ->
      $('.evaluation_form').each ->
        form_id = $(this).attr('id')
        set_values form_id, $('#' + form_id + '_score').val()
      
    $(document).on 'click', ".rating_score", (event) ->
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

