# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $(':checkbox').click ->
    count = $(':checked').length
    if count == 3
      $("input:checkbox:not(:checked)").attr "disabled", true
      $("input:checkbox:not(:checked)").parent().parent().addClass "disabled"
    else
      $(":checkbox").removeAttr "disabled"
      $("input:checkbox:not(:checked)").parent().parent().removeClass "disabled"
