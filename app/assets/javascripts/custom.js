$(document).ready(function() {
  var mymap = L.map('mapid').setView([25.789, -80.226], 11);
  L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
    // leaflet docs example
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',

    maxZoom: 18,

    id: 'josheche.pdnp8m55',

    accessToken: 'pk.eyJ1Ijoiam9zaGVjaGUiLCJhIjoiY2lsdGxkNDZ6MDA5dnVza3Ntb2k3MG5ucSJ9.dLVTcxnZoBfQ0LLLKQkdaA',

    // false if you want an unruly map
    sleep: true,

    // defines whether the user is prompted on how to wake map
    sleepNote: true,

    // specify a custom message to notify users how to wake
    wakeMessage: ('Click ' + 'to find Bitcoin Locations'),

    // opacity (between 0 and 1) of inactive map
    sleepOpacity: 0.7,
  }).addTo(mymap);
});
