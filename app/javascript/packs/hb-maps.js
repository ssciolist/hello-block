import mapboxgl from 'mapbox-gl';

mapboxgl.accessToken = 'pk.eyJ1IjoiYXJlbGxhbm9tZWdhbiIsImEiOiJjamp4Nmp5ZzYwd3o2M3dwYXA1Z2hpOG9jIn0.t9gtewJ5FXvJl9F6skfdPg'


let neighborhoodMap = new mapboxgl.Map({
  container: 'neighborhood-map-container',
  style: 'mapbox://styles/mapbox/streets-v9',
  center: [-104.962262, 39.737309],
  zoom: 10.5,
})

// zoom in and out button
let nav = new mapboxgl.NavigationControl();
neighborhoodMap.addControl(nav, 'top-right');

neighborhoodMap.on('load', function () {
  neighborhoodMap.addSource('nbhdPolygons', {
    type: 'geojson',
    data: 'https://raw.githubusercontent.com/ssciolist/credit_check/master/neighborhoods_w_sum.geojson'
  });

  neighborhoodMap.addLayer({
    id: 'nbhd-layer',
    type: 'fill',
    source: 'nbhdPolygons',
    layout: {
      visibility: 'visible'
    },
    paint: {
      'fill-color': {
        property: 'total',
        stops: [
          [4157428, '#240b36'],
          [28172883,'#971535'],
          [60446761.5, '#741335'],
          [187035524, '#490F35'],
          [1346648930, '#c31432']
        ]},
      'fill-outline-color': 'rgba(0,0,80,1)',
    }
  });

  // When a click event occurs on a feature in the nbhd layer, open a popup at the
  // location of the click, with description HTML from its properties.
    neighborhoodMap.on('click', 'nbhd-layer', function (e) {
        new mapboxgl.Popup()
            .setLngLat(e.lngLat)
            .setHTML('<p><b>Neighborhood name</b>: ' +
                      e.features[0].properties.name +
                      '</p><p><b>Total construction</b>: ' +
                      '$'+ e.features[0].properties.total.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,') +
                      '</p>' )
            .addTo(neighborhoodMap);
    });

    // Change the cursor to a pointer when the mouse is over the layer.
    neighborhoodMap.on('mouseenter', 'nbhd-layer', function () {
        neighborhoodMap.getCanvas().style.cursor = 'pointer';
    });

    // Change it back to a pointer when it leaves.
    neighborhoodMap.on('mouseleave', 'nbhd-layer', function () {
        neighborhoodMap.getCanvas().style.cursor = '';
    });
});


// variables that will sort the map view
let mapSort = [
    'Residential construction',
    'Commercial construction'];
