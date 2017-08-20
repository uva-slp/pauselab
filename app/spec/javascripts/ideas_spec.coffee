#= require ideas

describe "ideas", ->

  # done is a special jasmine parameter that allows us to test asynchronous functions
  beforeAll (done) ->
    fixture.load "idea.html", append=false
    $.getScript "https://maps.googleapis.com/maps/api/js?key=AIzaSyD4DSpVTh3mv6nZ9D3A9xUtdaX7YpScN28&libraries=places", ->
      done()
    # $.when(
    #   $.getScript "https://cdnjs.cloudflare.com/ajax/libs/es6-promise/4.1.0/es6-promise.auto.js",
    #
    #   $.Deferred ( deferred ) ->
    #     $( deferred.resolve )
    # ).done ->
    #   console.log("\nloaded")
    #   done()

  afterEach ->
    fixture.cleanup()

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

  it "calls setBounds when bounds changes", ->
    map = Idea.load_map {lat: 30, lng: -20}
    sbox = Idea.link_search_box(map)
    spyOn(sbox, 'setBounds')
    google.maps.event.trigger map, 'bounds_changed'
    expect(sbox.setBounds).toHaveBeenCalled()

  it "changes address when places changes", ->

    map = Idea.load_map {lat: 30, lng: -20}
    sbox = Idea.link_search_box(map)

    sbox.getPlaces = ->
      return [
        {
          formatted_address: "Lee Park",
          geometry: {
            location: new google.maps.LatLng(-34, 151)
          }
        }
      ]

    Idea.addressChange sbox, undefined, map
    expect($('.address').html()).toContain('Lee Park')

  it "calls geocoder when marker is dragged", ->

    spyOn(Idea, 'geocodePosition')
    map = Idea.load_map {lat: 30, lng: -20}
    sbox = Idea.link_search_box(map)
    sbox.getPlaces = ->
      return [
        {
          formatted_address: "Lee Park",
          geometry: {
            location: new google.maps.LatLng(-34, 151)
          }
        }
      ]

    marker = Idea.addressChange sbox, marker, map

    google.maps.event.trigger marker, 'dragend'
    expect(Idea.geocodePosition).toHaveBeenCalled()

  it "geocodes correctly", (done) ->
    spyOn(Idea, "populateAddress")
    jasmine.DEFAULT_TIMEOUT_INTERVAL = 10000
    pos = new google.maps.LatLng(37.020098, -77.167969)
    $.getScript "https://cdnjs.cloudflare.com/ajax/libs/es6-promise/4.1.0/es6-promise.auto.js", ->
      Idea.geocodePosition(pos).then ->
        expect(Idea.populateAddress).toHaveBeenCalled()
        done()

  it "populates address properly", ->
    pos = new google.maps.LatLng(37.020098, -77.167969)
    responses = [
      {
        formatted_address: '7710 Beef Steak Rd, Waverly, VA 23890, USA'
      }
    ]
    Idea.populateAddress responses, pos
    expect($('.address').html()).toEqual('7710 Beef Steak Rd, Waverly, VA 23890, USA')

  it "shows map correctly", (done) ->
    jasmine.DEFAULT_TIMEOUT_INTERVAL = 10000
    $.getScript "https://cdnjs.cloudflare.com/ajax/libs/es6-promise/4.1.0/es6-promise.auto.js", ->
      Idea.showMap().then ->
        expect($("#map").html().trim() != '')
        done()
