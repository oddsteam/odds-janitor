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
    // Get the current URL
    const currentUrl = new URL(window.location.href);

    // Get the search parameters
    const searchParams = currentUrl.searchParams;

    // Remove the 'id' parameter
    searchParams.delete('id');

    // Construct the new path
    const newPath = `${currentUrl.pathname}?${searchParams.toString()}`;

    // Update the browser's URL
    window.history.pushState({}, '', newPath);
  }
  
}