// app/javascript/controllers/blueprint_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal"];

  connect() {
    this.isOpen = false;
    this.isZoomed = false;
  }

  toggleZoom() {
    this.isZoomed = !this.isZoomed;
    this.modalTarget.classList.remove('hidden');
  }

  closeModal() {
    this.isOpen = false;
    this.modalTarget.classList.add('hidden');
  }
}
