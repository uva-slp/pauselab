
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
    map.controls[google.maps.ControlPosition.LEFT_TOP].push document.getElementById 'map-sidebar'
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
      marker = new (google.maps.Marker)(
          position: pos
          # icon: img
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
  "</p>" +
  "</div>"
  # toReturn =
  # return '<div class="marker-info"><span>' + 'sd' +'</span>' + idea.description + '<br><span class="text-muted">' + date.toDateString() + '</span></div>'
