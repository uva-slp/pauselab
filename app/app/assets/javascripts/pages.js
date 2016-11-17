

// # design pattern for page specific js load
//
// $(document).on "turbolinks:load", ->
//   return unless $(".ideas-map-info").length > 0
//
//   console.log 'here at pages'


function initMap() {

  var pos = {lat: 38.0293, lng: -78.4767};
  var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 10,
          center: pos
        });

  var bounds = new google.maps.LatLngBounds();
  $.get('/pages/ideas_json', function(ideas) {
    ideas.forEach(function(idea) {
      pos = {lat: parseFloat(idea.lat), lng: parseFloat(idea.lng)};
      var marker = new google.maps.Marker({
              position: pos,
              map: map
            });
      bounds.union(new google.maps.LatLngBounds(pos));
    });
  });

  map.fitBounds(bounds);

}
