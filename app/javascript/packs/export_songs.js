const exportSongsListener = () => {
  const btn = document.getElementById("export-btn");
  console.log("Inside Listner");
  btn.addEventListener('click', popup);
}

const popup = (event) => {
  console.log("Inside Popup");
  let playlist_name = prompt("Please enter the name of the playlist:", "");
  if (playlist_name != null){
    let request = new Request(`/export?${playlist_name}`);
    console.log(request);
    // window.location.href = "https://open.spotify.com/artist/6TKKVFCBfak1kInOPl7hCz";
  }
};

export { exportSongsListener };