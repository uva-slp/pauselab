
window.initMap = ->

  $.get 'ideas_json', (ideas) ->

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
    bounds = new (google.maps.LatLngBounds)(pos)
    infowindow = new (google.maps.InfoWindow)(
      maxWidth: 200
    )

    ideas.forEach (idea) ->
      date = new (Date)(idea.created_at)
      idea_info = '<div class="marker-info"><h5>Idea</h5>' + idea.description + '<br><span class="pull-right text-muted">' + date.toDateString() + '</span></div>'
      pos =
        lat: parseFloat(idea.lat)
        lng: parseFloat(idea.lng)

      img =
        url: "https://maxcdn.icons8.com/Color/PNG/512/Maps/marker-512.png"
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
        infowindow.setContent idea_info
        infowindow.open map, marker
        return
      m_bounds = new (google.maps.LatLngBounds)(pos)
      bounds.union m_bounds
      return

    map.fitBounds bounds
    return

  return
