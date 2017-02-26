
window.initMap = ->

  g = {}
  $.when(($.get 'ideas_json', (ideas) -> g.ideas = ideas),
  ($.get 'categories_json', (categories) -> g.categories = categories)).then ->

    ideas = g.ideas   # hash of publically visible fields of each idea
    categories = g.categories # maps category_id -> icon url (empty string if not present)

    pos =
      lat: 38.0293
      lng: -78.4767
    map = new (google.maps.Map)(document.getElementById('map'),
        zoom: 10
        center: pos
        clickableIcons: false
        mapTypeControl: false
        streetViewControl: false
      )
    map.controls[google.maps.ControlPosition.LEFT_TOP].push document.getElementById 'map-sidebar'
    map.controls[google.maps.ControlPosition.RIGHT_TOP].push document.getElementById 'new-idea-btn'
    $('#map-sidebar').hide()
    map.addListener 'click', ->
      $('#map-sidebar').fadeOut 200

    bounds = new (google.maps.LatLngBounds)(pos)
    infowindow = new (google.maps.InfoWindow)(
      maxWidth: 200
    )

    ideas.forEach (idea) ->
      idea_info = buildInfo idea
      pos =
        lat: parseFloat(idea.lat)
        lng: parseFloat(idea.lng)

      defaultUrl = "https://maxcdn.icons8.com/office/PNG/80/Maps/marker-80.png"
      img =
        url: categories[idea.category_id] || defaultUrl
        # size: new (google.maps.Size)(100, 100)
        # origin: new (google.maps.Point)(10, 15)
        # anchor: new (google.maps.Point)(0, 32)
        scaledSize: new (google.maps.Size)(50, 50)

      marker = new (google.maps.Marker)(
          position: pos
          icon: img
          map: map
          title: idea.created_at
        )
      marker.addListener 'click', ->
        $('#map-sidebar').html idea_info
        $('#map-sidebar').fadeIn 200
        infowindow.setContent idea_info
        # infowindow.open map, marker
        return
      m_bounds = new (google.maps.LatLngBounds)(pos)
      bounds.union m_bounds
      return

    map.fitBounds bounds
    return

  return

buildInfo = (idea) ->
  date = new (Date)(idea.created_at)
  address = idea.address
  return "<div class='marker-info'><img class='idea-img' src='https://www.sandiego.gov/sites/default/files/legacy/park-and-recreation/graphics/missionhills.jpg'><br><br><p class='idea-address'>" +
  address +
  "</p><p class='idea-description'>" +
  idea.description +
  "</p><p class='idea-date text-muted'>" +
  date.getMonth() + "/" + date.getDate() + "/" + date.getFullYear() +
  "</p>"
  +

  "<a>like</a>"

  +
  "</div>"
  # toReturn =
  # return '<div class="marker-info"><span>' + 'sd' +'</span>' + idea.description + '<br><span class="text-muted">' + date.toDateString() + '</span></div>'
