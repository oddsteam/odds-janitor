import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="time-table-modal"
export default class extends Controller {
  static targets = ["modal"]

  connect() {
  }
  openModal() {
    console.log("modal")
    this.modalTarget.classList.remove("hidden")
  }
  closeModal(){
    this.modalTarget.classList.add("hidden")
  }
}
