import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["selectedDate"]

  connect() {
    this.selectedDateValue = new Date(this.selectedDateTarget.textContent)
  }

  select(event) {
    event.preventDefault()
    console.log("select")

    const date = event.currentTarget.dataset.date
    // format September 04, 2024  
    const dateString = new Date(date).toLocaleString('default', { month: 'long', day: '2-digit', year: 'numeric' })
    this.selectedDateTarget.textContent = dateString
    this.clearHighlight()

    event.currentTarget.classList.add("bg-blue-500", "text-white", "hover:bg-blue-500")
    this.selectedDateValue = new Date(date)
  }

  clearHighlight() {
    const highlighted = this.element.querySelector(".bg-blue-500")
    if (highlighted) {
      highlighted.classList.remove("bg-blue-500", "text-white", "hover:bg-blue-500")
      highlighted.classList.add("text-gray-800")
    }
  }

  previousMonth(event) {
    event.preventDefault()
    this.changeMonth(-1)
  }

  nextMonth(event) {
    event.preventDefault()
    this.changeMonth(1)
  }

  changeMonth(offset) {
    this.selectedDateValue.setMonth(this.selectedDateValue.getMonth() + offset)
    this.updateCalendar()
  }

  updateCalendar() {
    // Update header with new month and year
    const header = this.element.querySelector(".calendar-header h2")
    header.textContent = this.selectedDateValue.toLocaleString('default', { month: 'long', year: 'numeric' })

    // Update the selected date display
    this.selectedDateTarget.textContent = this.selectedDateValue.toLocaleString('default', { month: 'long', day: '2-digit', year: 'numeric' })

    // Clear the calendar grid and regenerate it for the new month
    const calendarGrid = this.element.querySelector(".calendar-grid")
    calendarGrid.innerHTML = ""

    const daysInMonth = new Date(this.selectedDateValue.getFullYear(), this.selectedDateValue.getMonth() + 1, 0).getDate()
    
    for (let day = 1; day <= daysInMonth; day++) {
      const date = new Date(this.selectedDateValue.getFullYear(), this.selectedDateValue.getMonth(), day)
      const button = document.createElement("button")
      button.className = "calendar-day text-center p-2 cursor-pointer rounded hover:bg-blue-100 text-gray-800"
      button.dataset.action = "click->calendar#select"
      button.dataset.date = date.toISOString().split('T')[0]
      button.textContent = day

      if (this.selectedDateValue.getDate() === day) {
        button.classList.add("bg-blue-500", "text-white")
      }

      calendarGrid.appendChild(button)
    }
  }
}
