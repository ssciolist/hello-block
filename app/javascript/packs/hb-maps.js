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
    data: 'https://raw.githubusercontent.com/codeforamerica/click_that_hood/master/public/data/denver.geojson'
  });

  neighborhoodMap.addLayer({
    id: 'nbhdOutlines',
    type: 'fill',
    source: 'nbhdPolygons',
    layout: {
      visibility: 'visible'
    },
    paint: {
      'fill-color': 'rgba(61,153,80,0.55)'
    }
  });
});

// map colors
let hues = [
    '#eff3ff',
    '#bdd7e7',
    '#6baed6',
    '#3182bd',
    '#08519c'];

// variables that will sort the map view
let mapSort = [
    'Residential construction',
    'Commercial construction'];

// Collect the range of each variable over the full set, so
// we know what to color the brightest or darkest.
let ranges = {};
let $select = $('<select></select>')
    .appendTo($('#variables'))
    .on('change', function() {
        setVariable($(this).val());
    });
for (var i = 0; i < mapSort.length; i++) {
    ranges[variables[i]] = { min: Infinity, max: -Infinity };
    // Simultaneously, build the UI for selecting different
    // ranges
    $('<option></option>')
        .text(mapSort[i])
        .attr('value', variables[i])
        .appendTo($select);
}
