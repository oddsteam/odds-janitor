When('ฉันกดเลือกห้องที่ต้องการจอง') do
  @booking.choose_room_for_booking
end

And('ฉันกรอกรายละเอียดการจอง') do
  @booking.fill_booking_detail
end

And('ฉันกดยืนยันการจอง') do
  @booking.confirm_booking
end

Then('รายการจองของฉันจะแสดงขึ้นมา') do
  @booking.saw_booking_bar
end