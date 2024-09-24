import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reservations"
export default class extends Controller {
  static targets = ["newBooking", "table", "startTimer" ,"endTimer" ,"roomId"]
  connect() {
    console.log("hello world")
    this.isTracking = false
  }

  reservationDetailModal(e) {
    const startTimer = e.target.dataset.startTime
    const endTimer = e.target.dataset.endTime
    const roomId = e.target.dataset.roomId

    document.getElementById("modalRoomInfo").textContent = roomId;
    document.getElementById("modalStartTime").textContent = startTimer;
    document.getElementById("modalEndTime").textContent = endTimer;
  }

  mouseDown(e) {

    const tableRect = this.tableTarget.getBoundingClientRect();
    const rect = e.target.getBoundingClientRect();
    this.newBookingTarget.style.left = `${rect.left - tableRect.left}px`
    this.newBookingTarget.style.top = `${rect.top - tableRect.top}px`    
    this.newBookingTarget.style.width = `${rect.width}px`
    this.newBookingTarget.style.height = `${rect.height}px`

    this.startLeft = rect.left - tableRect.left
    this.newBookingTarget.classList.add('pointer-events-none')
    this.isTracking = true
    console.log("Dataset:",e.target.dataset)
    this.startTimer = e.target.dataset.startTime
    this.endTimer = e.target.dataset.endTime
    this.roomId = e.target.dataset.roomId
  }

  mouseUp() {
    console.log("mouseUp")
    this.isTracking = false
    this.startTimerTarget.value = this.startTimer
    this.endTimerTarget.value = this.endTimer
    this.roomIdTarget.value = this.roomId
  }

  mouseMove(e) {
    console.log("mouseMove")
    if (this.isTracking) {
      const tableRect = this.tableTarget.getBoundingClientRect();
      const rect = e.target.getBoundingClientRect();
      this.newBookingTarget.style.width = `${rect.right - tableRect.left - this.startLeft}px`
      console.log(rect.right - tableRect.left - this.startLeft)
      this.endTimer = e.target.dataset.endTime
      this.endTimerTarget.value = this.endTimer
    }
    

  }
}
