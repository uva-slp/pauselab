
#= require votes

describe "votes", ->

  beforeEach ->
    fixture.load "vote.html"

  afterEach ->
    fixture.cleanup()

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
    $('.proposal-checkbox').first().click()
    expect(Vote.checkCallback).toHaveBeenCalled()

  it "turns vote card green when checked", ->
    Vote.initialize()
    $('.proposal-checkbox').first().trigger 'click'
    expect(
      $('.proposal-checkbox').first().closest('label').hasClass('btn-success')
    ).toBe(true)

  it "removes green vote card outline if checked twice", ->
    Vote.initialize()
    $('.proposal-checkbox').first().trigger 'click'
    $('.proposal-checkbox').first().trigger 'click'
    expect(
      $('.proposal-checkbox').first().closest('label').hasClass('btn-outline-primary')
    ).toBe(true)

  it "disables checking if 3 vote cards are checked", ->
    Vote.initialize()
    $('.proposal-checkbox').each ->
      $(this).trigger 'click'
    expect($(':checked').length).toEqual(3)
