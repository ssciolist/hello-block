google.maps.event.addDomListener(window, 'load', initAutocomplete);
google.maps.event.addDomListener(window, 'load', initMap);

function initAutocomplete() {
  // Create the autocomplete object, restricting the search to geographical
  // location types.
  autocomplete = new google.maps.places.Autocomplete(
      /** @type {!HTMLInputElement} */(document.getElementById('autocomplete')),
      {types: ['geocode']});

}

// Bias the autocomplete object to the user's geographical location,
// as supplied by the browser's 'navigator.geolocation' object.
function geolocate() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      var circle = new google.maps.Circle({
        center: geolocation,
        radius: position.coords.accuracy
      });
      autocomplete.setBounds(circle.getBounds());
    });
  }
}

function initMap() {

  var start_lat = parseFloat(document.getElementById('map').dataset.start_lat)
  var start_long = parseFloat(document.getElementById('map').dataset.start_long)
  var permits = JSON.parse(document.getElementById('map').dataset.permits)


  var start_location = {lat: start_lat, lng: start_long};
  // The map, centered at Uluru
  var map = new google.maps.Map(
      document.getElementById('map'), {zoom: 16, center: start_location});
  // The marker, positioned at Uluru
  var marker = new google.maps.Marker({position: start_location, map: map});
  buildMarkers(permits, map)
}


const buildMarkers = (permits, map) => {
  for (var i = 0; i < permits.length; i++) {
    var permit = permits[i];
    var latLng = new google.maps.LatLng(permit.latitude,permit.longitude);
    var marker = new google.maps.Marker({
      position: latLng,
      icon: {
            path: google.maps.SymbolPath.CIRCLE,
            scale: 5,
            fillColor: 'red',
          },
      map: map
    });
    buildInfoWindow(marker, permit)
  }
}

const buildInfoWindow = (marker, data) => {
  var infoWindow = new google.maps.InfoWindow();
  google.maps.event.addListener(marker, "click", function(e) {
    infoWindow.setContent(`<b>Address:</b> ${data.address}<br>
                           <b>Building Class:</b> ${data.building_class}<br>
                           <b>Valuation:</b> ${data.valuation}<br>
                           <b>Owner:</b> ${data.owner_name}<br>
                           <b>Date Issued:</b> ${data.date_issued}`);
    infoWindow.open(map, marker)
  })
}
