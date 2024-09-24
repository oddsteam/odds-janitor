// app/javascript/controllers/preview_rooms_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal"];

  open(event) {
    event.preventDefault();
    this.modalTarget.classList.remove("hidden");
  }

  close(event) {
    event.preventDefault();
    this.modalTarget.classList.add("hidden");
  }}
