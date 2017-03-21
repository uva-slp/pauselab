#= require categories

describe "categories", ->

  beforeEach ->
    fixture.load "categories.html"
    console.log $('body').html()

  afterEach ->
    fixture.cleanup()

  # it "initializes correctly", ->
  #   spyOn(Category, 'onSubmit')
  #   Category.initialize()
  #   $('#new_category').submit()
  #   expect(Category.onSubmit).toHaveBeenCalled()

  it "adds error class when submitting blank category", ->
    Category.initialize()
    $('#new_category').submit()
    expect($('#category_name').attr('class')).toContain('has-error')

  # it "adds error class when submitting blank category", ->
  #   Category.initialize()
  #   $('#category_name').val 'sample'
  #   $('#new_category').submit()
  #   expect($('#category_name').attr('class')).not.toContain('has-error')
