# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on "turbolinks:load", ->

  # console.log($(':checked').length)

  addProposal = (title) ->
    $('.selected-proposals').append '<span class="btn btn-primary">' + title + '</span> &nbsp;'
  removeProposal = (title) ->
    proposal_span = $('.selected-proposals').children('span').filter((index) ->
      return $(this).html() == title
    ).remove()

  $(':checked').each ->
      # label = $(this).closest 'label'
      # card = $(this).closest '.card'
      # title = $(card).find('.card-title a').html()
      # card.css 'border', '1px solid #2ecc71'
      # label.removeClass 'btn-outline-primary'
      # label.addClass 'btn-success'
      # # addProposal title

  $(':checkbox').click (e) ->
    # e.preventDefault();

    count = $(':checked').length

    status = $(this).prop('checked')
    label = $(this).closest 'label'
    card = $(this).closest '.card'
    title = $(card).find('.card-title a').html()

    console.log status

    if status
      card.css 'border', '1px solid #2ecc71'
      label.removeClass 'btn-outline-primary'
      label.addClass 'btn-success'
      addProposal title
    else
      card.css 'border', '1px solid rgba(0, 0, 0, 0.125)'
      label.removeClass 'btn-success'
      label.addClass 'btn-outline-primary'
      removeProposal title

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









    # if count == 3
    #   $("input:checkbox:not(:checked)").attr "disabled", true
    #   console.log this
    #   $("input:checkbox:not(:checked)").parent().parent().addClass "disabled"
    # else
    #   $(":checkbox").removeAttr "disabled"
    #   $("input:checkbox:not(:checked)").parent().removeClass "active"
    #   $("input:checkbox:not(:checked)").parent().parent().removeClass "disabled"
