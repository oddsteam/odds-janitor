import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  closeAndRedirect(event) {
    event.preventDefault();
    this.hideModal();
    this.changePath();
  }

  navigate(event) {
    event.preventDefault();
    const reserveId = this.element.dataset.reserveId;
    const selectedDate = this.element.dataset.selectedDate;
    window.location.href = `/reserves?date=${selectedDate}&id=${reserveId}`;
  }

  hideModal() {
    this.element.style.display = "none";
  }

  changePath() {
    window.history.pushState({}, '', '/reserves');
  }
  
}