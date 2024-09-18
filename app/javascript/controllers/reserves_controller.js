import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["cell", "optionsStart", "optionsEnd"];
  dragging = false;
  selectedCells = [];
  startRow = null;
  startTime = null;
  endTime = null;

  option() {
    this.startTime 
    this.optionsStartTarget.innerHTML = '';
    this.optionsEndTarget.innerHTML = '';
    // create array of options to be added
    // เพิ่ม <option> elements เข้าไปใน optionTarget
    this.optionsStartTarget.appendChild(option1);
    this.optionsEndTarget.appendChild(option2);
  }

  handleStart(event) {
    event.preventDefault();
    this.dragging = true;
    this.removeHighlightCell();

    const cell = event.currentTarget;
    this.startRow = this.getRowIndex(cell);
    this.highlightCell(cell);

    this.startTime = cell.dataset.hour;
    this.endTime = this.calculateEndTime(this.startTime, 30);
  }

  handleMove(event) {
    if (!this.dragging) return;
    event.preventDefault();

    const cell = event.currentTarget;

    if (cell && cell.matches("[data-reserves-target='cell']")) {
      const currentRow = this.getRowIndex(cell);
      if (currentRow !== this.startRow) {
        return;
      }

      this.highlightCell(cell);

      const cellsDragged = this.selectedCells.length;
      this.endTime = this.calculateEndTime(this.startTime, cellsDragged * 30);
    }
  }

  handleEnd(event) {
    event.preventDefault();
    if (!this.dragging) return;
    this.dragging = false;

    this.openModalWithTimes(this.startTime, this.endTime);
  }

  highlightCell(cell) {
    if (!this.selectedCells.includes(cell)) {
      this.selectedCells.push(cell);
      cell.classList.add("bg-blue-300");
    }
  }

  removeHighlightCell() {
    this.selectedCells.forEach(cell => cell.classList.remove("bg-blue-300"));
    this.selectedCells = [];
  }

  getRowIndex(cell) {
    return cell.closest('tr').rowIndex;
  }

  calculateEndTime(startTime, duration) {
    const [startHours, startMinutes] = startTime.split(':').map(Number);
    let totalMinutes = startHours * 60 + startMinutes + duration;

    const endHours = Math.floor(totalMinutes / 60).toString().padStart(2, '0');
    const endMinutes = (totalMinutes % 60).toString().padStart(2, '0');

    return `${endHours}:${endMinutes}`;
  }

  generateTimeOptions() {
    const options = [];
    let start = 8 * 60; 
    let end = 19 * 60; 

    while (start <= end) {
      const hours = Math.floor(start / 60).toString().padStart(2, '0');
      const minutes = (start % 60).toString().padStart(2, '0');
      options.push(`${hours}:${minutes}`);
      start += 30;
    }
    return options;
  }

  openModalWithTimes(startTime, endTime) {
    const modal = document.getElementById('myModal');
    const startTimeSelect = document.getElementById('startTime');
    const endTimeSelect = document.getElementById('endTime');

    startTimeSelect.innerHTML = '';
    endTimeSelect.innerHTML = '';

    const timeOptions = this.generateTimeOptions();
    timeOptions.forEach(time => {
      const startOption = document.createElement("option");
      startOption.value = time;
      startOption.text = time;
      startTimeSelect.appendChild(startOption);

      const endOption = document.createElement("option");
      endOption.value = time;
      endOption.text = time;
      endTimeSelect.appendChild(endOption);
    });

    startTimeSelect.value = startTime;
    endTimeSelect.value = endTime;

    modal.classList.remove('hidden');
  }

  closeModal() {
    const modal = document.getElementById('myModal');
    modal.classList.add("hidden");
    this.removeHighlightCell();
  }

  submitForm(event) {
    event.preventDefault();

    const form = event.currentTarget;
    const formData = new FormData(form);
    for (let [key, value] of formData.entries()) {
      console.log(`${key}: ${value}`);
    }
    fetch('/reserves', {
      method: 'POST',
      body: formData,
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
        'Accept': 'text/vnd.turbo-stream.html, application/json'
      }
    })
    .then(response => {
      const contentType = response.headers.get("Content-Type");
      if (contentType && contentType.includes("text/vnd.turbo-stream.html")) {
        return response.text();
      }
      return response.json();
    })
    .then(data => {
      if (typeof data === 'string') {
        Turbo.renderStreamMessage(data);
        this.closeModal();
      } else if (data.status === 'success') {
        this.closeModal();
        // Optionally handle JSON response
      } else {
        console.error('Error:', data.errors);
      }
    })
    .catch(error => {
      console.error('Error:', error);
    });
  }
}