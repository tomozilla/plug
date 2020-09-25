function findMe() {
  console.log("getting geolocation")
    const geo = navigator.geolocation
    document.addEventListener('DOMContentLoaded',
    (event) => {
      if(geo) {

        //dummy one
        const startButtons = document.querySelectorAll("#event-index");
        const newStartButtonText = document.querySelector(".btn.btn-gradient");
        console.log("if navigator.geolocation has some coordinates");
        console.log(geo);
        geo.getCurrentPosition(function () {}, function () {}, {});
        //working one
        geo.getCurrentPosition(function(position) {
          const currentLatitude = position.coords.latitude;
          console.log(currentLatitude);
          const currentLongitude = position.coords.longitude;
          console.log(currentLongitude);
          console.log(startButtons);
          console.log(newStartButtonText);
          startButtons.forEach((startButton)=>{
          startButton.attributes.href.value = `${startButton.attributes.href.value}?lat=${currentLatitude}&lon=${currentLongitude}`;
          });
          newStartButtonText.text = "See Events";
        }, function(error) {
          console.log("if navigator.geolocation has errors");
          const currentLatitude = 35.642927;
          const currentLongitude = 139.825334;
          startButtons.forEach((startButton)=>{
          startButton.attributes.href.value = `${startButton.attributes.href.value}?lat=${currentLatitude}&lon=${currentLongitude}`;
          });
          newStartButtonText.text = "See Events";
        });
      } else {
        const currentLatitude = 35.642927;
        const currentLongitude = 139.825334;
        console.log("if navigator.geolocation is false");
        startButtons.forEach((startButton)=>{
        startButton.attributes.href.value = `${startButton.attributes.href.value}?lat=${currentLatitude}&lon=${currentLongitude}`;
        });
        newStartButtonText.text = "See Events";
      }
    })
  }

export { findMe };
