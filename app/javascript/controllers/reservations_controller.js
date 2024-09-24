import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reservations"
export default class extends Controller {
  static targets = ["newBooking", "table", "startTimer" ,"endTimer" ,"roomId"]
  connect() {
    console.log("hello world")
    this.isTracking = false
  }

  reservationDetailModal(e) {
    const startTimer = e.target.dataset.startTime;
    const endTimer = e.target.dataset.endTime;
    const roomId = parseInt(e.target.dataset.roomId);
    const bookedBy = e.target.dataset.bookedBy;
    const date = e.target.dataset.date;
    const note = e.target.dataset.note;
  
    const rooms = [
      { id: 1, name: "Meeting 1", address: "Binary Base", seat: 3 },
      { id: 2, name: "Meeting 2", address: "Binary Base", seat: 6 },
      { id: 3, name: "Territory 1", address: "Binary Base", seat: 5 },
      { id: 4, name: "Territory 2", address: "Binary Base", seat: 5 },
      { id: 5, name: "Territory 3", address: "Binary Base", seat: 5 },
      { id: 6, name: "Global", address: "Binary Base", seat: 30 },
      { id: 7, name: "All Nighter 1", address: "Binary Base", seat: 36 },
      { id: 8, name: "All Nighter 2", address: "Binary Base", seat: 32 },
    ];
  
    const room = rooms.find(r => r.id === roomId);
    const roomName = room ? room.name : "Unknown Room";
    const roomAddress = room ? room.address : "Unknown Address";
    const roomSeat = room ? room.seat : "Unknown Seat";
  
    document.getElementById("modalRoomName").textContent = roomName;
    document.getElementById("modalStartTime").textContent = startTimer;
    document.getElementById("modalEndTime").textContent = endTimer;
    document.getElementById("modalBookedBy").textContent = bookedBy;
    document.getElementById("modalDate").textContent = date;
    document.getElementById("modalLocation").textContent = roomAddress;
    document.getElementById("modalSeats").textContent = roomSeat;
    document.getElementById("modalNote").textContent = note;
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
