
class @Init

  @initialize: ->
    $ ->
      Init.init()
      Init.fbShare()
      Init.twtrShare()

  @init: ->
    $('[data-toggle="tooltip"]').tooltip()
    $('.btn').mouseup ->
      $(this).blur()

  @fbShare: ->
    $('.fb-btns').click ->
        window.open "https://www.facebook.com/sharer.php?u=" + window.location.host + '/idea/' + $(this).data('id'), 'share to facebook', 'height=350,width=500'

  @format: (desc, id) ->
    if desc.length > 50
      desc = desc.substring(0, 50) + "..."
    return "\"" + desc + "\" more at: " + window.location.host + '/idea/' + id

  @twtrShare: ->
    $('.twtr-btns').click ->
      desc = $(this).data 'desc'
      id = $(this).data 'id'
      desc = encodeURIComponent Init.format desc, id
      window.open "https://twitter.com/intent/tweet?text=" + desc, 'name', 'height=300,width=500'

  @redirect: (href) ->
      window.location = href

  @rowClicker: ->
    $('.row-link').each ->
      $(this).click ->
        Init.redirect($(this).data('href'))
      $(this).mouseover ->
        $(this).css 'cursor', 'pointer'
      # $(this).mouseleave ->
      #   $(this).css 'cursor', 'inherit'


Init.initialize()



# # gets loaded for the entire application
# window.App ||= {}
#
# # App.init = ->
# #   $('[data-toggle="tooltip"]').tooltip()
# #   $(".btn").mouseup ->
# #     $(this).blur()
# #   # $("a , span, i, div").tooltip()
#
# format = (desc, id) ->
#   if desc.length > 50
#     desc = desc.substring(0, 50) + "..."
#   return "\"" + desc + "\" more at: " + window.location.host + '/idea/' + id
#
# $ ->
#
#   App.init()
#
#   $('.fb-btns').click ->
#       window.open "https://www.facebook.com/sharer.php?u=" + window.location.host + '/idea/' + $(this).data('id'), 'share to facebook', 'height=350,width=500'
#
#   $('.twtr-btns').click ->
#     desc = $(this).data 'desc'
#     id = $(this).data 'id'
#     desc = encodeURIComponent format desc, id
#     window.open "https://twitter.com/intent/tweet?text=" + desc, 'name', 'height=300,width=500'
#
#   $('.row-link').each ->
#     $(this).click ->
#       window.location = $(this).data('href')
#     $(this).mouseover ->
#       $(this).css 'cursor', 'pointer'
#     $(this).mouseleave ->
#       $(this).css 'cursor', 'inherit'
#
#   return
