# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  # role_form = false
  # $(".role_form").hide()
  #
  # $("button[name='toggle_role_form']").click ->
  #   if !role_form
  #     $(".role_form").show()
  #     role_form = true
  #   else
  #     $(".role_form").hide()
  #     role_form = false

   $("a[data-remote]").on "ajax:success", (e, data, status, xhr) ->
     $('.iter-status').html data.status
