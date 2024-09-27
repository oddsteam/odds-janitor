Given('ฉันเข้าสู่ระบบแล้ว') do
  @lobby.visit_homepage
  @lobby.login
end

And('ฉันทำการจองแล้ว') do
  sleep 1
  @booking.choose_room_for_booking
  @booking.fill_booking_detail
  @booking.confirm_booking
  @booking.saw_booking_bar
end

When('ฉันกดดูรายการจองของฉัน') do
  @booking.click_my_booking
end