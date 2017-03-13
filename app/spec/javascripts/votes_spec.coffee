
#= require votes

describe "votes", ->

  beforeEach ->
    MagicLamp.load("votes/new")

  afterEach ->
    MagicLamp.clean()

  it "loads jquery", ->
    expect($).toBeDefined()

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
    spyOn Vote, 'checkCallback'
    Vote.addCheckListener()
    $(':checkbox').first().trigger 'click'
    expect(Vote.checkCallback).toHaveBeenCalled()

  it "checks when vote card is clicked", ->
    
