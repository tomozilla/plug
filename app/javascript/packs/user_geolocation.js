function findMe() {
  console.log("getting geolocation")
  // const urlParams = new URLSearchParams(window.location.search);
  // const myLat = urlParams.get('lat');
  // console.log("top");
  // if (myLat === null) {
    if(navigator.geolocation) {
      //dummy one
      navigator.geolocation.getCurrentPosition(function () {}, function () {}, {});
      //working one
      navigator.geolocation.getCurrentPosition(function(position) {
        const currentLatitude = position.coords.latitude;
        const currentLongitude = position.coords.longitude;
        // window.location.replace(`${window.location}?lat=${currentLatitude}&lon=${currentLongitude}`);
        const startButtons = document.querySelectorAll("#event-index");
        startButtons.forEach((startButton)=>{
        startButton.attributes.href.value = `${startButton.attributes.href.value}?lat=${currentLatitude}&lon=${currentLongitude}`;
        });
      }, function(error) {
        clearTimeout(location_timeout);
        geolocFail();
      });
    } else {
      geolocFail();
      const currentLatitude = 35.642927;
      const currentLongitude = 139.825334;
      const startButtons = document.querySelectorAll("#event-index");
      startButtons.forEach((startButton)=>{
      startButton.attributes.href.value = `${startButton.attributes.href.value}?lat=${currentLatitude}&lon=${currentLongitude}`;
      });
    }
  // }
}

export { findMe };
