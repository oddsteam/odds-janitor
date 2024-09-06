import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

import ReservesController from "./reserves_controller"
application.register("reserves", ReservesController)

// import CalendarController from "./calendar_controller"
// application.register("calendar", CalendarController)

// import ReservationController from "./reservation_controller"
// application.register("reservation", ReservationController)
