// app/javascript/controllers/preview_rooms_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal", "roomName", "roomImage1", "roomImage2", "roomImage3"];

  open(event) {
    event.preventDefault();
    
    // Get room data from the button's data attributes
    const roomName = event.currentTarget.dataset.roomName;
    const roomImage1 = event.currentTarget.dataset.roomImage1;
    const roomImage2 = event.currentTarget.dataset.roomImage2;
    const roomImage3 = event.currentTarget.dataset.roomImage3;

    // Update the modal with room data
    this.roomNameTarget.textContent = roomName;
    this.roomImage1Target.src = roomImage1;
    // Update other images if required
    this.roomImage2Target.src = roomImage2;
    this.roomImage3Target.src = roomImage3;
    
    this.modalTarget.classList.remove("hidden");
  }

  close(event) {
    event.preventDefault();
    this.modalTarget.classList.add("hidden");
  }}
