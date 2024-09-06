import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["cell"];
  dragging = false;
  selectedCells = [];
  startRow = null;

  st = null;
  et = null;

  handleStart(event) {
    event.preventDefault();
    this.dragging = true;
    this.clearSelection(); // ลบ row ที่เลือกไว้ก่อนหน้า ก่อนลากใหม่
    this.startRow = this.getRowIndex(event.currentTarget); // ลาก row เปลี่ยนสี
    this.selectCell(event.currentTarget); // ตัวเปลี่ยนสี

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
    this.dragging = false;
    this.et = event.currentTarget.dataset.half;
    console.log('endTime: ' + this.et);
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
}
