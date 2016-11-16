

// # design pattern for page specific js load
//
// $(document).on "turbolinks:load", ->
//   return unless $(".ideas-map-info").length > 0
//
//   console.log 'here at pages'


function initMap() {
  var uluru = {lat: -25.363, lng: 131.044};
  var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 8,
          center: uluru
        });
  var marker = new google.maps.Marker({
          position: uluru,
          map: map
        });
}
