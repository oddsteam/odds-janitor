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
  }
  
  handleMove(event) {
    if (!this.dragging) return;
    event.preventDefault();
    const element = event.currentTarget;
    if (element && element.matches("[data-booking-table-target='cell']")) {
      const currentRow = this.getRowIndex(element);
      
      if (currentRow === this.startRow) {
        this.selectCell(element);
      } else {
        this.handleRowBoundary(element);
        this.endTime = this.getTimeFromCell(element); // Update end time
        this.updateTimeDisplays(); // Update time displays
      }
    }
  }
  
  handleEnd(event) {
    event.preventDefault();
    this.dragging = false;
    this.endTime = this.getTimeFromCell(event.currentTarget); // Update end time
    this.updateTimeDisplays(); // Update time displays
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
