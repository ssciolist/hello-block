import mapboxgl from 'mapbox-gl';


mapboxgl.accessToken = 'pk.eyJ1IjoiYXJlbGxhbm9tZWdhbiIsImEiOiJjamp4Nmp5ZzYwd3o2M3dwYXA1Z2hpOG9jIn0.t9gtewJ5FXvJl9F6skfdPg'

let neighborhoodMap = new mapboxgl.Map({
  container: 'neighborhood-map-container',
  style: 'mapbox://styles/mapbox/streets-v9',
  center: [-104.962262, 39.737309],
  zoom: 10.5,
  zoomControl: true
})
