# $ ->
#   $('.fb-btns').click ->
#       window.open "https://www.facebook.com/sharer.php?u=" + window.location.host + '/idea/' + $(this).data('id'), 'share to facebook', 'height=350,width=500'
#   $('.twtr-btns').click ->
#     desc = $(this).data 'desc'
#     id = $(this).data 'id'
#     desc = encodeURIComponent format desc, id
#     window.open "https://twitter.com/intent/tweet?text=" + desc, 'name', 'height=300,width=500'
#   return

# format = (desc, id) ->
#   if desc.length > 50
#     desc = desc.substring(0, 50) + "..."
#   return "\"" + desc + "\" more at: " + window.location.host + '/idea/' + id

window.initAutocomplete = ->
  pos =
    lat: 38.0293
    lng: -78.4767
  map = load_map pos
  link_search_box map
  return

load_map = (pos, zoom = 10) ->
  map = new (google.maps.Map)(document.getElementById('map'),
    center: pos
    zoom: zoom
    mapTypeId: 'roadmap'
    mapTypeControl: false
    streetViewControl: false)
  return map

link_search_box = (map) ->
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
    console.log 'places_changed'
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
      geocodePosition marker.getPosition()

    if place.geometry.viewport
      bounds.union place.geometry.viewport
    else
      bounds.extend place.geometry.location

    # sets the viewport to the given bounds
    map.fitBounds bounds
    return

  return

geocodePosition = (pos) ->
  geocoder = new (google.maps.Geocoder)()
  geocoder.geocode { latLng: pos }, (responses) ->
    if responses and responses.length > 0
      addr =  responses[0].formatted_address
      $('#idea_lat').val pos.lat
      $('#idea_lng').val pos.lng
      $('#idea_address').val addr
      $('.address').html addr
    return
  return

window.showMap = ->
  pos =
    lat: $('#map').data('lat')
    lng: $('#map').data('lng')
  cat_id = $('#map').data('cat')

  defaultUrl = "https://maxcdn.icons8.com/office/PNG/80/Maps/marker-80.png"

  # TODO: this URL is not working in the pegasus server
  $.get '/pages/categories_json', (categories) ->
    img =
      url: categories[cat_id] || defaultUrl
      scaledSize: new (google.maps.Size)(50, 50)
    # console.log(pos);
    map = load_map(pos, 18)
    marker = new (google.maps.Marker)(
      map: map
      position: pos
      icon: img
    )

  return
