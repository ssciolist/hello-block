import mapboxgl from 'mapbox-gl';

mapboxgl.accessToken = 'pk.eyJ1IjoiYXJlbGxhbm9tZWdhbiIsImEiOiJjamp4Nmp5ZzYwd3o2M3dwYXA1Z2hpOG9jIn0.t9gtewJ5FXvJl9F6skfdPg'


var neighborhoodMap = new mapboxgl.Map({
  container: 'neighborhood-map-container',
  style: 'mapbox://styles/mapbox/streets-v9',
  center: [-104.962262, 39.737309],
  zoom: 10.5,
});

// zoom in and out button
let nav = new mapboxgl.NavigationControl();
neighborhoodMap.addControl(nav, 'top-right');

neighborhoodMap.on('load', function () {
  neighborhoodMap.addSource('nbhdPolygonsALL', {
    type: 'geojson',
    data: 'http://localhost:3000/api/v1/building_permits/neighborhoods/summarize?class=all&years=2015,2016,2017,2018'
  });

  neighborhoodMap.addLayer({
    id: 'All since 2015',
    type: 'fill',
    source: 'nbhdPolygonsALL',
    layout: {
      visibility: 'none'
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

  neighborhoodMap.addSource('nbhdPolygons2015', {
    type: 'geojson',
    data: 'http://localhost:3000/api/v1/building_permits/neighborhoods/summarize?class=all&years=2015'
  });

  neighborhoodMap.addLayer({
    id: '2015',
    type: 'fill',
    source: 'nbhdPolygons2015',
    layout: {
      visibility: 'none'
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

  neighborhoodMap.addSource('nbhdPolygons2016', {
    type: 'geojson',
    data: 'http://localhost:3000/api/v1/building_permits/neighborhoods/summarize?class=all&years=2016'
  });

  neighborhoodMap.addLayer({
    id: '2016',
    type: 'fill',
    source: 'nbhdPolygons2016',
    layout: {
      visibility: 'none'
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

  neighborhoodMap.addSource('nbhdPolygons2017', {
    type: 'geojson',
    data: 'http://localhost:3000/api/v1/building_permits/neighborhoods/summarize?class=all&years=2017'
  });

  neighborhoodMap.addLayer({
    id: '2017',
    type: 'fill',
    source: 'nbhdPolygons2017',
    layout: {
      visibility: 'none'
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

  neighborhoodMap.addSource('nbhdPolygons2018', {
    type: 'geojson',
    data: 'http://localhost:3000/api/v1/building_permits/neighborhoods/summarize?class=all&years=2018'
  });

  neighborhoodMap.addLayer({
    id: '2018',
    type: 'fill',
    source: 'nbhdPolygons2018',
    layout: {
      visibility: 'none'
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
});

var toggleableLayerIds = [ 'All since 2015', '2018', '2017', '2016', '2015' ];

for (var i = 0; i < toggleableLayerIds.length; i++) {
    var id = toggleableLayerIds[i];

    var link = document.createElement('a');
    link.href = '#';
    link.className = 'inactive';
    link.textContent = id;

    link.onclick = function (e) {
        var clickedLayer = this.textContent;
        e.preventDefault();
        e.stopPropagation();

        // Change the cursor to a pointer when the mouse is over the layer.
        neighborhoodMap.on('mouseenter', clickedLayer, function () {
            neighborhoodMap.getCanvas().style.cursor = 'pointer';
        });

        // Change it back to a pointer when it leaves.
        neighborhoodMap.on('mouseleave', clickedLayer, function () {
            neighborhoodMap.getCanvas().style.cursor = '';
        });

        // When a click event occurs on a feature in the nbhd layer, open a popup at the
        // location of the click, with description HTML from its properties.
          neighborhoodMap.on('click', clickedLayer, function (e) {
              new mapboxgl.Popup()
                  .setLngLat(e.lngLat)
                  .setHTML('<p><b>Neighborhood name</b>: ' +
                            e.features[0].properties.name +
                            '</p><p><b>Total construction</b>: ' +
                            '$'+ e.features[0].properties.total.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,') +
                            '</p>' )
                  .addTo(neighborhoodMap);
          });

        var visibility = neighborhoodMap.getLayoutProperty(clickedLayer, 'visibility');

        if (visibility === 'visible') {
            neighborhoodMap.setLayoutProperty(clickedLayer, 'visibility', 'none');
            this.className = '';
        } else {
            this.className = 'active';
            neighborhoodMap.setLayoutProperty(clickedLayer, 'visibility', 'visible');
        }
    };

    var layers = document.getElementById('menu');
    layers.appendChild(link);
}
