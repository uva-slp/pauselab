# window.initAutocomplete = ->
#   pos =
#     lat: 38.0293
#     lng: -78.4767
#   map = load_map pos
#   link_search_box map
#   return

class @Idea

  @initialize: ->
    pos =
      lat: 38.0293
      lng: -78.4767
    map = Idea.load_map pos
    Idea.link_search_box map
    return

  @load_map: (pos, zoom = 9) ->
    map = new (google.maps.Map)(document.getElementById('map'),
      center: pos
      zoom: zoom
      mapTypeId: 'roadmap'
      mapTypeControl: false
      streetViewControl: false)
    return map

  @link_search_box: (map) ->
    input = document.getElementById('pac-input')
    searchBox = new (google.maps.places.SearchBox)(input)
    map.controls[google.maps.ControlPosition.TOP_LEFT].push input

    # Bias the SearchBox results towards current map's viewport.
    map.addListener 'bounds_changed', ->
      searchBox.setBounds map.getBounds()
      return

    # Listen for the event fired when the user selects a prediction and retrieve
    # more details for that place.
    marker = undefined
    searchBox.addListener 'places_changed', ->
      marker = Idea.addressChange(searchBox, marker, map)

    return searchBox

  @addressChange: (searchBox, marker, map) ->

    # console.log 'places_changed'
    places = searchBox.getPlaces()
    if places.length == 0
      return

    place = places[0]
    address = place.formatted_address
    lat = place.geometry.location.lat()
    lng = place.geometry.location.lng()
    $('.address').html address
    $('#idea_lat').val lat
    $('#idea_lng').val lng
    $('#idea_address').val address

    # Clear out the old markers.
    if marker
      marker.setMap null

    # For each place, get the icon, name and location.
    bounds = new (google.maps.LatLngBounds)
    if !place.geometry
      console.log 'Returned place contains no geometry'
      return

    marker = new (google.maps.Marker)(
      map: map
      draggable: true
      position: place.geometry.location
    )

    google.maps.event.addListener marker, 'dragend', (e) ->
      Idea.geocodePosition marker.getPosition()

    if place.geometry.viewport
      bounds.union place.geometry.viewport
    else
      bounds.extend place.geometry.location

    # sets the viewport to the given bounds
    map.fitBounds bounds
    return marker

  @geocodePosition: (pos) ->
    geocoder = new (google.maps.Geocoder)()
    return new Promise((resolve, reject) ->
      geocoder.geocode { latLng: pos }, (responses, status) ->
        if status == 'OK'
          Idea.populateAddress responses, pos
          resolve()
        else
          reject()
        return
    )
    #
    # geocoder.geocode { latLng: pos }, (responses, status) ->
    #   Idea.populateAddress responses, pos
    # return

  @populateAddress: (responses, pos) ->
    if responses and responses.length > 0
      addr =  responses[0].formatted_address
      $('#idea_lat').val pos.lat
      $('#idea_lng').val pos.lng
      $('#idea_address').val addr
      $('.address').html addr
    return

  @showMap = ->
    pos =
      lat: $('#map').data('lat')
      lng: $('#map').data('lng')
    cat_id = $('#map').data('cat')

    defaultUrl = "https://maxcdn.icons8.com/office/PNG/80/Maps/marker-80.png"

    return new Promise((resolve, reject) ->
      $.get '/pages/categories_json', (categories) ->
        img =
          url: categories[cat_id] || defaultUrl
          scaledSize: new (google.maps.Size)(50, 50)
        map = Idea.load_map(pos, 15)
        marker = new (google.maps.Marker)(
          map: map
          position: pos
          icon: img
        )
        resolve()
    )

    return
