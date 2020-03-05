import "bootstrap";
import { findMe } from './user_geolocation';

if (document.querySelector("#event-index")) {
  findMe();
}

