import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["cell", "startTime", "endTime" , "st", "et"];
  dragging = false;
  selectedCells = [];
  startRow = null;
  startTime = null;
  endTime = null;

  st = null;
  et = null;

  connect() {
    console.log("Booking table controller connected");
    document.addEventListener('mouseup', this.handleEnd.bind(this));
  }

  disconnect() {
    document.removeEventListener('mouseup', this.handleEnd.bind(this));
  }

  handleStart(event) {
    event.preventDefault();
    this.dragging = true;
    this.clearSelection();
    this.startRow = this.getRowIndex(event.currentTarget); // Track the starting row
    this.startTime = this.getTimeFromCell(event.currentTarget)

    this.selectCell(event.currentTarget);
    this.updateTimeDisplays(); // Update time displays

     // Log data-hour and data-half from the cell
    this.st = event.currentTarget.dataset.hour;
    console.log('startTime: ' + this.st);
  }
  
  handleMove(event) {
    if (!this.dragging) return;
    event.preventDefault();
    const element = event.currentTarget;
    
    if (element && element.matches("[data-booking-table-target='cell']")) {
      const currentRow = this.getRowIndex(element);
      
      // Check if the current row is the same as the start row
      if (currentRow === this.startRow) {
        this.selectCell(element);
        this.endTime = this.getTimeFromCell(element); // Update end time
        this.updateTimeDisplays(); // Update time displays
      } else {
        // If dragging across a different row, stop and end the drag
        console.log("Dragged across rows, stopping the selection.");
        this.handleEnd(event); // Call handleEnd to finish the selection process
      }
    }
  }
  
  handleEnd(event) {
    event.preventDefault();
    if (!this.dragging) return;
    const element = event.currentTarget;
    const currentRow = this.getRowIndex(element);
    this.et = event.currentTarget.dataset.half;
    
    // If we're still in the same row, update endTime
    if (currentRow === this.startRow) {
      this.endTime = this.getTimeFromCell(element); // Update end time
      this.updateTimeDisplays(); // Update time displays
      // Log data-hour and data-half from the cell
    }
    console.log('endTime: ' + this.et);
    
    // End dragging and clear state regardless of the row
    this.dragging = false;

    fetch('/reserves/modal', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify({ start_time: this.st, end_time: this.et })
    })
    .then(response => response.json())
    .then(data => {
      console.log('Success:', data);
    })
    .catch((error) => {
      console.error('Error:', error);
    });
  }
  

  handleTouchMove(event) {
    const touch = event.touches[0];
    const element = document.elementFromPoint(touch.clientX, touch.clientY);
    if (element && element.matches("[data-booking-table-target='cell']")) {
      this.handleMove({ currentTarget: element });
    }
  }

  selectCell(cell) {
    if (!this.selectedCells.includes(cell)) {
      this.selectedCells.push(cell);
      cell.classList.add("bg-blue-300");
    }
  }

  clearSelection() {
    this.selectedCells.forEach(cell => cell.classList.remove("bg-blue-300"));
    this.selectedCells = [];
  }

  getRowIndex(cell) {
    return cell.closest('tr').rowIndex;
  }

  handleRowBoundary(element) {
    const currentRow = this.getRowIndex(element);
    const startRowCells = Array.from(document.querySelectorAll(`[data-room="${this.startRow}"]`));
    startRowCells.forEach(cell => this.selectCell(cell));
  }

  getTimeFromCell(cell) {
    // Ensure cell content is in 'HH:MM' format
    return cell.textContent.trim();
  }
  

  updateTimeDisplays() {
    if (this.startTime) {
      this.startTimeTarget.textContent = this.startTime;
    }
    if (this.endTime) {
      this.endTimeTarget.textContent = this.endTime;
    }
  }
}
