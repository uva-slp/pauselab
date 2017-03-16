# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  $('#new_category').submit ->
    cat = $('#category_name').val().trim()
    if !cat
      $('.category_name').addClass('has-error')
      $('.category_name').append("<span class='help-block' data-original-title='' title=''>can't be blank</span>")
      return false
