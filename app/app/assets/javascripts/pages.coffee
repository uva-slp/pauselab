
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
      idea_info = '<div><p>' + idea.description + '</p><span class="pull-right text-muted">' + date.toDateString() + '</span></div>'
      pos =
        lat: parseFloat(idea.lat)
        lng: parseFloat(idea.lng)
      marker = new (google.maps.Marker)(
          position: pos
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
