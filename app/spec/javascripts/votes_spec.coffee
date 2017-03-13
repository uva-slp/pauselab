
#= require votes

describe "votes", ->

  it "loads jquery", ->
    expect($).toBeDefined()

  it "test test", ->
    # v = new Vote
    r = add 1, 2
    expect(r).toBe(3)
