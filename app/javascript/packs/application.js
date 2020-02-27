import "bootstrap";
import { findMe } from './user_geolocation';
import { exportSongsListener } from './export_songs';

if (document.querySelector("#event-index")) {
  findMe();
}
