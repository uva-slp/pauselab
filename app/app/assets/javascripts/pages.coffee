
class @Pages

  @initialize: ->
    g = {
      ne: {
        lat: 38.042987,
        lng: -78.480079
      },
      sw: {
        lat: 38.0293,
        lng: -78.4767
      }
    }
    $.when(
      ($.get 'ideas_json', (ideas) -> g.ideas = ideas),
      ($.get 'categories_json', (categories) -> g.categories = categories)
    ).then ->
      map = Pages.showMap(g)
      Pages.fillMap map, g

  @showMap: (g) ->

    map = new (google.maps.Map)(document.getElementById('map'),
        zoom: 10
        center: g.sw
        clickableIcons: false
        mapTypeControl: false
        streetViewControl: false
      )

    return map

  @fillMap: (map, g) ->

    ideas = g.ideas   # hash of publically visible fields of each idea
    categories = g.categories # maps category_id -> icon url (empty string if not present)

    map.controls[google.maps.ControlPosition.RIGHT_TOP].push document.getElementById 'new-idea-btn'

    bounds = new (google.maps.LatLngBounds)(g.ne, g.sw)
    infowindow = new (google.maps.InfoWindow)(
      maxWidth: 200
    )

    map.addListener 'click', ->
      infowindow.close()

    markers = []

    ideas.forEach (idea) ->
      idea_info = Pages.buildInfo idea
      pos =
        lat: parseFloat(idea.lat)
        lng: parseFloat(idea.lng)

      defaultUrl = "https://maxcdn.icons8.com/office/PNG/80/Maps/marker-80.png"
      img =
        url: categories[idea.category_id] || defaultUrl
        scaledSize: new (google.maps.Size)(40, 40)

      marker = new (google.maps.Marker)(
          position: pos
          icon: img
          map: map
          title: idea.created_at
        )

      markers.push(marker)

      marker.addListener 'click', ->
        infowindow.setContent Pages.buildInfo idea
        infowindow.open map, marker
        return

      m_bounds = new (google.maps.LatLngBounds)(pos)
      bounds.union m_bounds
      return

    map.fitBounds bounds
    return markers

  @buildInfo = (idea) ->

    date = new (Date)(idea.created_at)
    date_string = date.getMonth() + "/" + date.getDate() + "/" + date.getFullYear()
    elem = $("<div class='infobox'></div>")
    desc = $("<span></span>")
    date_elem = $("<p class='idea-date text-muted'></p>")
    date_elem.append date_string
    desc.append idea.description
    fb_btn = $("<button class='btn btn-sm btn-primary no-outline'><i class='fa fa-facebook-square'></i></button>")
    twtr_btn = $("<button class='btn btn-sm btn-primary no-outline'><i class='fa fa-twitter-square'></i></button>")

    format = ->
      desc = idea.description
      if desc.length > 50
        desc = desc.substring(0, 50) + "..."
      return "\"" + desc + "\" more at: " + window.location.host + '/ideas/' + idea.id

    $(fb_btn).click ->
      window.open "https://www.facebook.com/sharer.php?u=" + window.location.host + '/ideas/' + idea.id, 'share to facebook', 'height=350,width=500'
    $(twtr_btn).click ->
      desc = encodeURIComponent format idea.description
      window.open "https://twitter.com/intent/tweet?text=" + desc, 'name', 'height=300,width=500'

    $(elem).append desc, date_elem, fb_btn, '&nbsp;&nbsp;', twtr_btn
    return elem[0]
