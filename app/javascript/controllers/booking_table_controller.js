import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["cell", "startTime", "endTime"];
  dragging = false;
  selectedCells = [];
  startRow = null;
  startTime = null;
  endTime = null;

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
    this.startTime = this.getTimeFromCell(event.currentTarget);
    this.selectCell(event.currentTarget);
    this.updateTimeDisplays(); // Update time displays

     // Log data-hour and data-half from the cell
    const startTime = event.currentTarget.dataset.hour;
    console.log('startTime: ' + startTime);
  }
  
  handleMove(event) {
    if (!this.dragging) return;
    event.preventDefault();
    const element = event.currentTarget;
    const endTime = event.currentTarget.dataset.half;
    
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
    const endTime = event.currentTarget.dataset.half;
    
    // If we're still in the same row, update endTime
    if (currentRow === this.startRow) {
      this.endTime = this.getTimeFromCell(element); // Update end time
      this.updateTimeDisplays(); // Update time displays
      // Log data-hour and data-half from the cell
      console.log('endTime: ' + endTime);
    }
    console.log('endTime: ' + endTime);
    
    // End dragging and clear state regardless of the row
    this.dragging = false;
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
