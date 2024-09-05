import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="reservation"
export default class extends Controller {
  static targets = ["selectedDate"];

  connect() {
    this.setSelectedDate(new Date(this.selectedDateTarget.textContent));
  }

  select(event) {
    event.preventDefault();
    const date = event.currentTarget.dataset.date;
    console.log('Event target:', event.currentTarget); // Debugging
    this.highlightSelectedDate(date, event.currentTarget)
  
    this.updateSelectedDate(date)
      .then(() => {})
      .catch(this.handleError);
  }

  previousMonth(event) {
    event.preventDefault();
    this.changeMonth(-1);
  }

  nextMonth(event) {
    event.preventDefault();
    this.changeMonth(1);
  }

  setSelectedDate(date) {
    this.selectedDateValue = date;
  }

  updateSelectedDate(date) {
    return fetch('/reserves/update_selected_date', {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify({ date })
    })
      .then(this.validateResponse)
      .then(this.parseResponse)
      .then(data => this.updateDateDisplay(date));
  }

  validateResponse(response) {
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
    return response.text(); // Use text() instead of json() to handle empty responses
  }

  parseResponse(text) {
    return text ? JSON.parse(text) : {}; // Parse only if text is not empty
  }

  updateDateDisplay(date) {
    const formattedDate = new Date(date).toLocaleString('default', { month: 'long', day: '2-digit', year: 'numeric' });
    this.selectedDateTargets.forEach(target => {
      target.textContent = formattedDate;
    });
  }

  highlightSelectedDate(date, element) {
    this.clearHighlight();
    element.classList.add("bg-blue-500", "text-white", "hover:bg-blue-500");
    this.setSelectedDate(new Date(date));
  }
  

  clearHighlight() {
    const highlighted = this.element.querySelector(".bg-blue-500");
    if (highlighted) {
      highlighted.classList.remove("bg-blue-500", "text-white", "hover:bg-blue-500");
      highlighted.classList.add("text-gray-800");
    }
  }
  

  changeMonth(offset) {
    this.selectedDateValue.setMonth(this.selectedDateValue.getMonth() + offset);
    this.updateCalendar();
  }

  updateCalendar() {
    this.updateHeader();
    this.generateCalendarGrid();
  }

  updateHeader() {
    const header = this.element.querySelector(".reservation-header h2");
    header.textContent = this.selectedDateValue.toLocaleString('default', { month: 'long', year: 'numeric' });
  }

  generateCalendarGrid() {
    const calendarGrid = this.element.querySelector(".reservation-grid");
    calendarGrid.innerHTML = "";

    const daysInMonth = new Date(this.selectedDateValue.getFullYear(), this.selectedDateValue.getMonth() + 1, 0).getDate();
    for (let day = 1; day <= daysInMonth; day++) {
      this.createCalendarDay(day, calendarGrid);
    }
  }

  createCalendarDay(day, calendarGrid) {
    const date = new Date(this.selectedDateValue.getFullYear(), this.selectedDateValue.getMonth(), day);
    const button = document.createElement("button");
    button.className = "reservation-day text-center p-2 cursor-pointer rounded hover:bg-blue-100 text-gray-800";
    button.dataset.action = "click->reservation#select";
    button.dataset.date = date.toISOString().split('T')[0];
    button.textContent = day;

    if (this.selectedDateValue.getDate() === day) {
      button.classList.add("bg-blue-500", "text-white");
    }

    calendarGrid.appendChild(button);
  }

  handleError(error) {
    console.error('There was a problem with the fetch operation:', error);
  }
}
