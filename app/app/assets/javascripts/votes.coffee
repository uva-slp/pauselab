
class @Vote

  @addProposal: (title) ->
    $('.selected-proposals').append '<span class="btn btn-primary">' + title + '</span> &nbsp;'
    return

  @removeProposal: (title) ->
    proposal_span = $('.selected-proposals').children('span').filter((index) ->
      return $(this).html() == title
    ).remove()
    return

  @checkCallback: (elem) ->

    # console.log "\non add check callback"

    count = $(':checked').length

    status = $(elem).prop('checked')
    label = $(elem).closest 'label'
    card = $(elem).closest '.card'
    title = $(card).find('.card-title a').html()

    if status
      card.css 'border', '1px solid #2ecc71'
      label.removeClass 'btn-outline-primary'
      label.addClass 'btn-success'
      Vote.addProposal title
    else
      card.css 'border', '1px solid rgba(0, 0, 0, 0.125)'
      label.removeClass 'btn-success'
      label.addClass 'btn-outline-primary'
      Vote.removeProposal title

    if count == 3
      $("input:checkbox:not(:checked)").attr "disabled", true
      $("input:checkbox:not(:checked)").parent().parent().addClass "disabled"
      $("input:checkbox:not(:checked)").parent().removeClass "btn-outline-primary"
      $("input:checkbox:not(:checked)").parent().addClass "btn-outline-secondary"
    else
      $(":checkbox").removeAttr "disabled"
      $("input:checkbox:not(:checked)").parent().parent().removeClass "disabled"
      $("input:checkbox:not(:checked)").parent().addClass "btn-outline-primary"
      $("input:checkbox:not(:checked)").parent().removeClass "btn-outline-secondary"

    return

  @addCheckListener: ->
    # console.log "\non add check listener"
    $('input[type="checkbox"]').on 'click', ->
    # console.log "\non add check callback"

    count = $(':checked').length

    status = $(elem).prop('checked')
    label = $(elem).closest 'label'
    card = $(elem).closest '.card'
    title = $(card).find('.card-title a').html()

    if status
      card.css 'border', '1px solid #2ecc71'
      label.removeClass 'btn-outline-primary'
      label.addClass 'btn-success'
      Vote.addProposal title
    else
      card.css 'border', '1px solid rgba(0, 0, 0, 0.125)'
      label.removeClass 'btn-success'
      label.addClass 'btn-outline-primary'
      Vote.removeProposal title

    if count == 3
      $("input:checkbox:not(:checked)").attr "disabled", true
      $("input:checkbox:not(:checked)").parent().parent().addClass "disabled"
      $("input:checkbox:not(:checked)").parent().removeClass "btn-outline-primary"
      $("input:checkbox:not(:checked)").parent().addClass "btn-outline-secondary"
    else
      $(":checkbox").removeAttr "disabled"
      $("input:checkbox:not(:checked)").parent().parent().removeClass "disabled"
      $("input:checkbox:not(:checked)").parent().addClass "btn-outline-primary"
      $("input:checkbox:not(:checked)").parent().removeClass "btn-outline-secondary"

    return

$ ->
  Vote.addCheckListener()
