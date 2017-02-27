window.fb = (idea) ->
  console.log 'facebook'

window.twtr = (idea) ->
  console.log 'twitter'

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

    # map.controls[google.maps.ControlPosition.LEFT_TOP].push document.getElementById 'map-sidebar'
    map.controls[google.maps.ControlPosition.RIGHT_TOP].push document.getElementById 'new-idea-btn'

    # $('#map-sidebar').hide()
    # map.addListener 'click', ->
    #   $('#map-sidebar') .fadeOut 200

    $('#fb-btn').click ->
      console.log 'idea here'

    $('#twtr-btn').click ->
      console.log 'idea'

    bounds = new (google.maps.LatLngBounds)(pos)
    infowindow = new (google.maps.InfoWindow)(
      maxWidth: 200
    )

    map.addListener 'click', ->
      infowindow.close()

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
        # $('#map-sidebar').html idea_info
        infowindow.setContent buildInfo idea
        infowindow.open map, marker
        return

      m_bounds = new (google.maps.LatLngBounds)(pos)
      bounds.union m_bounds
      return

    map.fitBounds bounds
    return

  return

buildInfo = (idea) ->
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
    if desc > 50
      desc = desc.substring(0, 50) + "..."
    return "\"" + desc + "\" more at: " + window.location.host + '/idea/' + idea.id

  $(fb_btn).click ->
    window.open "https://www.facebook.com/sharer.php?u=" + window.location.host + '/idea/' + idea.id, 'share to facebook', 'height=350,width=500'
  $(twtr_btn).click ->
    desc = encodeURIComponent format idea.description
    window.open "https://twitter.com/intent/tweet?text=" + desc, 'name', 'height=300,width=500'

  $(elem).append desc, date_elem, fb_btn, '&nbsp;&nbsp;', twtr_btn
  return elem[0]

  # address = idea.address
  # content = "<div class='infobox'><span class='idea-description'>" + idea.description + \
  # "</span><p class='idea-date text-muted'>" + date.getMonth() + "/" + date.getDate() + "/" + \
  # date.getFullYear() + "</p>" + "<div class='share-btns'><button onClick='fb(" + ")' class='btn btn-sm btn-primary'><i class='fa fa-facebook-square'></i></button>" + \
  # "&nbsp;&nbsp;<button onClick='twtr(" + ")' class='btn btn-sm btn-primary'><i class='fa fa-twitter-square'></i></button></div>" + "</div>"
  # return content
