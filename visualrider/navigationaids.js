mapboxgl.accessToken = ""; // Replace with your Mapbox access token
let map;
let currentLocationMarker;
let destinationMarker;

// Initialize the map
function initMap() {
    map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/streets-v11',
        center: [0, 0], // Initial coordinates
        zoom: 13
    });
}

// Find and highlight the route
document.getElementById('find-route-btn').addEventListener('click', () => {
    const currentLocationInput = document.getElementById('current-location').value;
    const destinationInput = document.getElementById('destination').value;

    if (currentLocationInput && destinationInput) {
        // Get coordinates for the current location
        fetch(`https://api.mapbox.com/geocoding/v5/mapbox.places/${encodeURIComponent(currentLocationInput)}.json?access_token=${mapboxgl.accessToken}`)
            .then(response => response.json())
            .then(data => {
                if (data.features.length > 0) {
                    const currentLocationCoords = data.features[0].geometry.coordinates;
                    
                    // Place a marker for the current location
                    if (currentLocationMarker) {
                        currentLocationMarker.remove();
                    }
                    currentLocationMarker = new mapboxgl.Marker({ color: "blue" })
                        .setLngLat(currentLocationCoords)
                        .setPopup(new mapboxgl.Popup().setText(currentLocationInput))
                        .addTo(map);
                    
                    // Now get the coordinates for the destination
                    fetch(`https://api.mapbox.com/geocoding/v5/mapbox.places/${encodeURIComponent(destinationInput)}.json?access_token=${mapboxgl.accessToken}`)
                        .then(response => response.json())
                        .then(data => {
                            if (data.features.length > 0) {
                                const destinationCoords = data.features[0].geometry.coordinates;

                                // Place a marker for the destination
                                if (destinationMarker) {
                                    destinationMarker.remove();
                                }
                                destinationMarker = new mapboxgl.Marker({ color: "red" })
                                    .setLngLat(destinationCoords)
                                    .setPopup(new mapboxgl.Popup().setText(destinationInput))
                                    .addTo(map);

                                // Find the shortest path
                                findShortestPath(currentLocationCoords, destinationCoords);
                            } else {
                                alert("Destination not found.");
                            }
                        })
                        .catch(error => console.error("Error:", error));
                } else {
                    alert("Current location not found.");
                }
            })
            .catch(error => console.error("Error:", error));
    } else {
        alert("Please enter both current location and destination.");
    }
});

// Function to find the shortest path using Mapbox Directions API
function findShortestPath(start, end) {
    const url = `https://api.mapbox.com/directions/v5/mapbox/driving/${start[0]},${start[1]};${end[0]},${end[1]}?geometries=geojson&access_token=${mapboxgl.accessToken}`;
    
    fetch(url)
        .then(response => response.json())
        .then(data => {
            if (data.routes.length > 0) {
                const route = data.routes[0].geometry.coordinates;
                drawRoute(route);
                map.fitBounds([start, end], { padding: 20 });
            } else {
                alert("No route found.");
            }
        })
        .catch(error => console.error("Error:", error));
}

// Draw the route on the map
function drawRoute(route) {
    // Remove previous route if exists
    if (map.getSource('route')) {
        map.removeLayer('route');
        map.removeSource('route');
    }

    map.addSource('route', {
        'type': 'geojson',
        'data': {
            'type': 'Feature',
            'geometry': {
                'type': 'LineString',
                'coordinates': route
            }
        }
    });

    map.addLayer({
        'id': 'route',
        'type': 'line',
        'source': 'route',
        'layout': {
            'line-join': 'round',
            'line-cap': 'round'
        },
        'paint': {
            'line-color': '#888',
            'line-width': 8
        }
    });
}

// Initialize the map on page load
window.onload = initMap;
