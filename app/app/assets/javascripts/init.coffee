
# gets loaded for the entire application
window.App ||= {}

App.init = ->
  $('[data-toggle="tooltip"]').tooltip()
  $(".btn").mouseup ->
    $(this).blur()
  # $("a , span, i, div").tooltip()

$ ->
  App.init()
