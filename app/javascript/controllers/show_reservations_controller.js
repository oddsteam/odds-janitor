import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-reservations"
export default class extends Controller {
  static targets = ["reservationBar", "table"]
  connect() {
    console.log("showreservations")
    this.reservationBarTargets.forEach((element, index) => {
      console.log(element.dataset)
      const roomId = element.dataset.roomId
      const startTime = element.dataset.startTime
      const endTime = element.dataset.endTime
      console.log(roomId,startTime,endTime)
      const startTimeCell = document.querySelector(`.timeCell[data-room-id="${element.dataset.roomId}"][data-start-time="${element.dataset.startTime}"]`)
      const startTimeCellRect = startTimeCell.getBoundingClientRect();
      console.log(startTimeCellRect)
      const tableRect = this.tableTarget.getBoundingClientRect();
      console.log(this.tableTarget)
      const left = startTimeCellRect.left - tableRect.left
      const top = startTimeCellRect.top - tableRect.top
      element.style.left =`${left}px`
      element.style.top = `${top}px`
      element.style.height = `${startTimeCellRect.height}px`
      console.log("startTimeCell", startTimeCellRect)
      const endTimeCell = document.querySelector(`.timeCell[data-room-id="${element.dataset.roomId}"][data-end-time="${element.dataset.endTime}"]`)
      const endTimeCellRect = endTimeCell.getBoundingClientRect();
      const width = endTimeCellRect.right - startTimeCellRect.left
      element.style.width = `${width}px`
      console.log("reserveBar")
    })
  }
}
