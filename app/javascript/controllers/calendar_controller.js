import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["selectedDate"]

  select(event) {
    event.preventDefault()
    console.log("select")

    const date = event.currentTarget.dataset.date
    this.selectedDateTarget.textContent = date
    this.clearHighlight()

    event.currentTarget.classList.add("bg-blue-500", "text-white")
  }

  clearHighlight() {
    const highlighted = this.element.querySelector(".bg-blue-500")
    if (highlighted) {
      highlighted.classList.remove("bg-blue-500", "text-white")
      highlighted.classList.add("text-gray-800")
    }
  }
}
