

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
          center: pos,
          clickableIcons: false,
          mapTypeControl: false,
          streetViewControl: false,
        });

  var bounds = new google.maps.LatLngBounds();
  $.get('ideas_json', function(ideas) {
    ideas.forEach(function(idea) {
      console.log(idea);

      var idea_info = "<div>" + idea.description + "</div>";
      var infowindow = new google.maps.InfoWindow({
        content: idea_info,
        maxWidth: 200
      });

      pos = {lat: parseFloat(idea.lat), lng: parseFloat(idea.lng)};
      var marker = new google.maps.Marker({
              position: pos,
              map: map,
              title: idea.created_at
            });
      marker.addListener('click', function() {
        infowindow.open(map, marker);
      });
      bounds.union(new google.maps.LatLngBounds(pos));

    });
  });

  map.fitBounds(bounds);

}
