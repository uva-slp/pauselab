
#= require init

describe "init", ->

  beforeEach ->
    fixture.load "init.html"

  afterEach ->
    fixture.cleanup()

  it "initializes properly", ->
    spyOn(Init, 'init')
    Init.initialize()
    expect(Init.init).toHaveBeenCalled()

  it "formats correctly with less than 50 characters", ->
    desc = "Lorem ipsum dolor sit amet"
    id = 5
    result = Init.format desc, id
    expected = "\"" + desc + "\" more at: " + window.location.host + '/ideas/' + id
    expect(result).toEqual(expected)

  it "formats correctly with more than 50 characters", ->
    desc = "Lorem ipsum dolor sit amet more more more more more more more"
    id = 5
    result = Init.format desc, id
    expect(result).toContain("...")

  it "shares to twitter", ->
    spyOn(window, 'open')
    Init.twtrShare()
    $('.twtr-btns').first().click()
    expect(window.open).toHaveBeenCalled()

  it "shares to facebook", ->
    spyOn(window, 'open')
    Init.fbShare()
    $('.fb-btns').first().click()
    expect(window.open).toHaveBeenCalled()

  it "makes rows clickable", ->
    spyOn(Init, 'redirect')
    Init.rowClicker()
    $('.row-link').first().click()
    expect(Init.redirect).toHaveBeenCalled()

  it "changes cursor to pointer on row hover", ->
    Init.rowClicker()
    row = $('.row-link').first()
    row.mouseover()
    cursor = row.css('cursor')
    expect(cursor).toEqual('pointer')
