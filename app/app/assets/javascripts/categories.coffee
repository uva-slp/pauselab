

class @Category

  @initialize: ->
    $ ->
      $('#new_category').submit ->
        Category.onSubmit()

  @onSubmit: ->
    cat = $('#category_name').val().trim()
    if !cat
      $('.category_name').addClass('has-error')
      $('.category_name').append("<span class='help-block' data-original-title='' title=''>can't be blank</span>")
      return false

Category.initialize()
