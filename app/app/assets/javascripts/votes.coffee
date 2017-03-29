
class @Vote

  @initialize: ->
    $ ->
      Vote.addCheckListener()
      $('#submit-button').on 'click', ->
        return Vote.validatePledge()
      $('#honor-pledge').on 'click', ->
        Vote.pledgeBoxListener this

  @addProposal: (title) ->
    $('.selected-proposals').append '<span class="btn btn-primary">' + title + '</span> &nbsp;'
    return

  @removeProposal: (title) ->
    proposal_span = $('.selected-proposals').children('span').filter((index) ->
      return $(this).html() == title
    ).remove()
    return

  @checkCallback: (elem) ->

    count = $('.proposal-checkbox:checked').length

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
      $(".proposal-checkbox:not(:checked)").attr "disabled", true
      $(".proposal-checkbox:not(:checked)").parent().parent().addClass "disabled"
      $(".proposal-checkbox:not(:checked)").parent().removeClass "btn-outline-primary"
      $(".proposal-checkbox:not(:checked)").parent().addClass "btn-outline-secondary"
    else
      $(".proposal-checkbox").removeAttr "disabled"
      $(".proposal-checkbox:not(:checked)").parent().parent().removeClass "disabled"
      $(".proposal-checkbox:not(:checked)").parent().addClass "btn-outline-primary"
      $(".proposal-checkbox:not(:checked)").parent().removeClass "btn-outline-secondary"

    return

  @addCheckListener: ->
    $('.proposal-checkbox').on 'click', ->
      Vote.checkCallback this
      return

  @validatePledge: ->
    if !($("#honor-pledge").is(":checked"))
      $("#honor-pledge").parent().addClass "btn-danger"
      return false
    return true

  @pledgeBoxListener: (elem) ->
    if $(elem).is(":checked")
      $("#honor-pledge").parent().removeClass "btn-danger"
    return true

Vote.initialize()
