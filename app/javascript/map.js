let map;
let marker;

window.initMap = function () {
  const latInput = document.getElementById("post_latitude");
  const lngInput = document.getElementById("post_longitude");
  const mapElement = document.getElementById("map"); 

  if (!mapElement) return; 

  let center;

  // ① new / edit（hidden_field がある）
  if (latInput && lngInput && latInput.value && lngInput.value) {
    center = {
      lat: parseFloat(latInput.value),
      lng: parseFloat(lngInput.value),
    };
  // ② show（data 属性）
  } else if (mapElement.dataset.lat && mapElement.dataset.lng) {
    center = {
      lat: parseFloat(mapElement.dataset.lat),
      lng: parseFloat(mapElement.dataset.lng),
    };

  } else {
    center = { lat: 35.681236, lng: 139.767125 }; // 東京駅
  }

  map = new google.maps.Map(mapElement, {
    center: center,
    zoom: 12,
  });

  marker = new google.maps.Marker({
    position: center,
    map: map,
  });

  // show ではクリックさせない
  if (latInput && lngInput) {
    map.addListener("click", (e) => {
      placeMarker(e.latLng);
    });
  }
};

function placeMarker(location) {
  marker.setPosition(location);

  document.getElementById("post_latitude").value = location.lat();
  document.getElementById("post_longitude").value = location.lng();
}
