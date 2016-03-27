$(document).ready(function() {

  // init the map bro
  var map = L.map('mapid').setView([25.789, -80.226], 13);

  // load up those tiles bro
  L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {

    // leaflet docs example
    attribution: 'Map markers &copy; <a href="https://bitstop.co">Bitstop</a>',

    maxZoom: 18,

    id: 'josheche.pdnp8m55',

    accessToken: 'pk.eyJ1Ijoiam9zaGVjaGUiLCJhIjoiY2lsdGxkNDZ6MDA5dnVza3Ntb2k3MG5ucSJ9.dLVTcxnZoBfQ0LLLKQkdaA',

  }).addTo(map);
});
