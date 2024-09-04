import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["date"]

  select(event) {
    event.preventDefault()
    const date = event.currentTarget.dataset.date
    console.log("Selected date:", date)
    // Perform an action with the selected date
  }
}