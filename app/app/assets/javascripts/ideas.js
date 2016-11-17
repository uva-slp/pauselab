

function initAutocomplete() {
  var pos = {lat: 38.0293, lng: -78.4767};
  var map = load_map(pos);
  link_search_box(map);
}

function load_map(pos, zoom = 10) {
  var map = new google.maps.Map(document.getElementById('map'), {
    // arbitrarily picked cville b/c geolocation was slow
    center: pos,
    zoom: zoom,
    mapTypeId: 'roadmap',
    mapTypeControl: false,
    streetViewControl: false,
  });
  return map;
}

function link_search_box(map) {

  var input = document.getElementById('pac-input');
  var searchBox = new google.maps.places.SearchBox(input);
  // this adds the custom search control at the top left position
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

  // Bias the SearchBox results towards current map's viewport.
  map.addListener('bounds_changed', function() {
    searchBox.setBounds(map.getBounds());
  });

  // Listen for the event fired when the user selects a prediction and retrieve
  // more details for that place.
  var marker;
  searchBox.addListener('places_changed', function() {

    var places = searchBox.getPlaces();
    if (places.length == 0)
      return;

    // TODO: for multiple places, pick the closest one

    var place = places[0];
    console.log(place);
    var address = place.formatted_address;
    var lat = place.geometry.location.lat();
    var lng = place.geometry.location.lng();

    $('.address').html(address);
    $("#idea_lat").val(lat);
    $("#idea_lng").val(lng);
    $("#idea_address").val(address);

    // Clear out the old markers.
    if (marker)
      marker.setMap(null);

    // For each place, get the icon, name and location.
    var bounds = new google.maps.LatLngBounds();

    if (!place.geometry) {
      console.log("Returned place contains no geometry");
      return
    }

    marker = new google.maps.Marker({
      map: map,
      position: place.geometry.location,
    });

    if (place.geometry.viewport)
      bounds.union(place.geometry.viewport);
    else
      bounds.extend(place.geometry.location);

    // sets the viewport to the given bounds
    map.fitBounds(bounds);

  });

}

function showMap() {
  var pos = {lat: $("#map").data('lat'), lng: $("#map").data('lng')};
  // console.log(pos);
  var map = load_map(pos, 18);
  var marker = new google.maps.Marker({
    map: map,
    position: pos,
  });
}
