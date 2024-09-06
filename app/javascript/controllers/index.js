import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

import ReservesController from "./reserves_controller"
application.register("reserves", ReservesController)

import ModalDetailController from "./modal_detail_controller"
application.register("modal-detail", ModalDetailController)

// import ReservationController from "./reservation_controller"
// application.register("reservation", ReservationController)
