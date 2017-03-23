#= require ideas

describe "ideas", ->

  # done is a special jasmine parameter that allows us to test asynchronous functions
  beforeAll (done) ->
    fixture.load "idea.html"
    $.getScript "https://maps.googleapis.com/maps/api/js?callback=Idea.initialize&libraries=places", ->
      done()

  # afterEach ->
  #   fixture.cleanup()

  it "loads google maps", ->
    expect(google.maps).toBeDefined()

  it "initializes correctly", ->
    spyOn(Idea, 'link_search_box')
    Idea.initialize()
    expect(Idea.link_search_box).toHaveBeenCalled()

  it "creates a map object", ->
    map = Idea.load_map {lat: 30, lng: -20}
    expect(map).toBeDefined()

  it "calls address change when places changes", ->
    spyOn(Idea, 'addressChange')
    map = Idea.load_map {lat: 30, lng: -20}
    sbox = Idea.link_search_box(map)
    google.maps.event.trigger sbox, 'places_changed'
    expect(Idea.addressChange).toHaveBeenCalled()
