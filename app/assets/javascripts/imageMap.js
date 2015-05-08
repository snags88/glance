$(function(){
    earth = new WE.map('earth_div', Map.options);
    WE.tileLayer('http://data.webglearth.com/natural-earth-color/{z}/{x}/{y}.jpg', {
          tileSize: 150,
          bounds: [[-85, -180], [85, 180]],
          minZoom: 0,
          maxZoom: 16,
          attribution: 'WebGLEarth example',
          tms: true
        }).addTo(earth);
});

var Map = new function() {
  this.options = { zoom: 3.0, position: [47.19537,8.524404] };
  // this.earth = new WE.map;
}

var panTo = function(coords) {
        earth.panTo(coords);
      }

      // earth = new WE.map('earth_div', Map.options);