function findMe() {
  console.log("getting geolocation")
  // const urlParams = new URLSearchParams(window.location.search);
  // const myLat = urlParams.get('lat');
  // console.log("top");
  // if (myLat === null) {
    if(navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
        const currentLatitude = position.coords.latitude;
        const currentLongitude = position.coords.longitude;
        // window.location.replace(`${window.location}?lat=${currentLatitude}&lon=${currentLongitude}`);
        const startButtons = document.querySelectorAll("#event-index");
        startButtons.forEach((startButton)=>{
        startButton.attributes.href.value = `${startButton.attributes.href.value}?lat=${currentLatitude}&lon=${currentLongitude}`;
        });
      }, function() {
        alert('We couldn\'t find your position.');
      });
    } else {
      alert('Your browser doesn\'t support geolocation.');
    }
  // }
}

export { findMe };
