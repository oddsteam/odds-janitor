import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reservations"
export default class extends Controller {
  static targets = ["newBooking", "table", "startTimer", "endTimer", "roomId"]
  
  connect() {
    console.log("hello world")
    this.isTracking = false
  }

  reservationDetailModal(e) {
    const reservationDetail = JSON.parse(e.target.dataset.reservationDetail);
    const roomId = parseInt(reservationDetail.roomId);
    const roomsData = document.getElementById('roomsData').textContent;
    const rooms = JSON.parse(roomsData);

    const room = rooms.find(r => r.id === roomId);
    const roomName = room ? room.name : "Unknown Room";
    const roomAddress = room ? room.address : "Unknown Address";
    const roomSeat = room ? room.seat : "Unknown Seat";

    document.getElementById("modalRoomName").textContent = roomName;
    document.getElementById("modalStartTime").textContent = reservationDetail.start_timer;
    document.getElementById("modalEndTime").textContent = reservationDetail.end_timer;
    document.getElementById("modalBookedBy").textContent = reservationDetail.userId;
    document.getElementById("modalDate").textContent = reservationDetail.date;
    document.getElementById("modalLocation").textContent = roomAddress;
    document.getElementById("modalSeats").textContent = roomSeat;
    document.getElementById("modalNote").textContent = reservationDetail.note;
  }

  mouseDown(e) {
    // Get the table and time cell dimensions
    const tableRect = this.tableTarget.getBoundingClientRect();
    const rect = e.target.getBoundingClientRect();

    // Set initial values for the new booking position
    this.newBookingTarget.style.left = `${rect.left - tableRect.left}px`
    this.newBookingTarget.style.top = `${rect.top - tableRect.top}px`
    this.newBookingTarget.style.width = `${rect.width}px`
    this.newBookingTarget.style.height = `${rect.height}px`

    // Store initial start time, room, and position for tracking
    this.startLeft = rect.left - tableRect.left
    this.startTop = rect.top - tableRect.top
    this.isTracking = true

    // Store start timer and end timer
    this.startTimer = e.target.dataset.startTime
    this.endTimer = e.target.dataset.endTime
    this.roomId = e.target.dataset.roomId

    // Hide pointer events during drag
    this.newBookingTarget.classList.add('pointer-events-none')

    console.log("Start Dragging:", this.startTimer, this.endTimer, this.roomId)
  }

  mouseMove(e) {
    if (this.isTracking) {
      const tableRect = this.tableTarget.getBoundingClientRect();
      const rect = e.target.getBoundingClientRect();
      
      // Check if the end time is after the start time
      const selectedEndTime = e.target.dataset.endTime;
      if (this.endTimer >= selectedEndTime) {
        // Prevent dragging backwards
        return;
      }
  
      // Continue as normal if end time is valid
      this.newBookingTarget.style.width = `${rect.right - tableRect.left - this.startLeft}px`;
      console.log(rect.right - tableRect.left - this.startLeft);
  
      this.endTimer = selectedEndTime;
      this.endTimerTarget.value = this.endTimer;
    }
  }

  mouseUp() {
    const availableTimes = Array.from(this.endTimerTarget.options)
    if (this.isTracking) {
      console.log("Drag Ended")

      // Stop tracking the drag
      this.isTracking = false
      this.newBookingTarget.classList.remove('pointer-events-none')

      // Assign the final start, end, and room values to the hidden form inputs
      this.startTimerTarget.value = this.startTimer
      this.endTimerTarget.value = this.endTimer
      this.roomIdTarget.value = this.roomId
    
      availableTimes.forEach((option) => {
        if (option.value <= this.startTimerTarget.value) {
          option.disabled = true
        } else {
          option.disabled = false
        }
      })
      console.log("Final Selection - Start:", this.startTimer, "End:", this.endTimer)
    }
  }
  
  updateEndTimeOptions() {
    const startTime = this.startTimerTarget.value
    const availableTimes = Array.from(this.endTimerTarget.options)
  
    // Reset end time selection if it's invalid
    if (this.endTimerTarget.value <= startTime) {
      this.endTimerTarget.value = "" // Reset end time if it conflicts with new start time
    }
  
    availableTimes.forEach((option) => {
      if (option.value <= startTime) {
        option.disabled = true
      } else {
        option.disabled = false
      }
    })
  }
}
