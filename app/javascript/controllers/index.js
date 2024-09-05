import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

import BookingTableController from "./booking_table_controller" // ชื่อไฟล์และตัวแปรตรงนี้ต้องตรงกัน
application.register("booking-table", BookingTableController) // ตรวจสอบชื่อว่าเป็น booking-table

// import CalendarController from "./calendar_controller"
// application.register("calendar", CalendarController)

// import ReservationController from "./reservation_controller"
// application.register("reservation", ReservationController)
