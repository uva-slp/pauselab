
#= require votes

describe "votes", ->

  beforeEach ->
    MagicLamp.load("votes/new")

  afterEach ->
    MagicLamp.clean()

  it "loads jquery", ->
    expect($).toBeDefined()

  it "initializes properly", ->
    spyOn(Vote, 'addCheckListener').and.callThrough()
    Vote.initialize()
    expect(Vote.addCheckListener).toHaveBeenCalled()

  it "adds proposal", ->
    c_old = $('.selected-proposals').children().length
    Vote.addProposal "proposal title"
    c_new = $('.selected-proposals').children().length
    expect(c_new - c_old).toEqual(1)

  it "removes proposal", ->
    Vote.addProposal "proposal title"
    c_old = $('.selected-proposals').children().length
    Vote.removeProposal "proposal title"
    c_new = $('.selected-proposals').children().length
    expect(c_new - c_old).toEqual(-1)

  it "triggers check listener", ->
    spyOn(Vote, 'checkCallback').and.callThrough()
    Vote.initialize()
    console.log $('body').html()
    $(':checkbox').first().click()
    expect(Vote.checkCallback).toHaveBeenCalled()

  it "turns vote card green when checked", ->
    Vote.initialize()
    $(':checkbox').first().trigger 'click'
    expect(
      $(':checkbox').first().closest('label').hasClass('btn-success')
    ).toBe(true)

  it "removes green vote card outline if checked twice", ->
    Vote.initialize()
    $(':checkbox').first().trigger 'click'
    $(':checkbox').first().trigger 'click'
    expect(
      $(':checkbox').first().closest('label').hasClass('btn-outline-primary')
    ).toBe(true)

  it "disables checking if 3 vote cards are checked", ->
    Vote.initialize()
    $(':checkbox').each ->
      $(this).trigger 'click'
    expect($(':checked').length).toEqual(3)
