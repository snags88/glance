var map = L.map('map', {
    center: , //Initial geographical center of the map.
    zoom: , //Initial map zoom
    minZoom: , //Minimum zoom level of the map
    maxZoom: , //Maximum zoom level of the map
    //Interaction Options
});

//Map State modifications
//setView( <LatLng> center,<Number> zoom?,<zoom/pan options> options? )
//setZoom( <Number> zoom, <zoom options> options? )
//panTo( <LatLng> latlng, <pan options> options? )
//openPopup( <String> html | <HTMLElement> el, <LatLng> latlng, <Popup options> options? )

//Makers
//L.marker( <LatLng> latlng,<Marker options> options? )

//MultiPolyLine
//draw path between multiple points given coordinates