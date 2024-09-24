import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reservation-detail-modal"
export default class extends Controller {
  static targets = ["reservationDetail"]

  connect() {
    console.log("Reservation controller is connected")
  }

  openModal() {
    this.reservationDetailTarget.classList.remove("hidden");
  } 

  closeModal() {
    this.reservationDetailTarget.classList.add("hidden");
  }
}
