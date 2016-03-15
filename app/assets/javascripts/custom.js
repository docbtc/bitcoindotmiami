$(document).ready(function() {
  var mymap = L.map('mapid').setView([25.789, -80.226], 11);
  L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
    maxZoom: 18,
    id: 'josheche.pdnp8m55',
    accessToken: 'pk.eyJ1Ijoiam9zaGVjaGUiLCJhIjoiY2lsdGxkNDZ6MDA5dnVza3Ntb2k3MG5ucSJ9.dLVTcxnZoBfQ0LLLKQkdaA'
  }).addTo(mymap);
});
