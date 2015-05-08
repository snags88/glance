$(function(){
  if($('.earth_div')[0]){
    earth = new WE.map('earth_div', Map.options);
    Map.layer.addTo(earth);
    Markers.placeAll
    $(".button").on("click", panTo)
  }
});

var Map = new function() {
  this.options = { zoom: 3.0, position: [47.19537,8.524404] };
  this.layer = WE.tileLayer('http://data.webglearth.com/natural-earth-color/{z}/{x}/{y}.jpg', {
          tileSize: 150,
          bounds: [[-85, -180], [85, 180]],
          minZoom: 0,
          maxZoom: 16,
          attribution: 'WebGLEarth example',
          tms: true
        })
}

var Markers = {
  placeAll: function(){

  }
}

var panTo = function() {
        var coords = $(this).data("coordinates")
        earth.panTo(coords);
        var marker = WE.marker(coords).addTo(earth);

        var location = $(this).data("location");
        var src = $(this).data("src");

        marker.bindPopup("<img src="+src+" width='150' height='150'><br><p>"+location+"</p>", {maxWidth: 150, closeButton: true}).openPopup();

      }
