When('ฉันกดเลือกวันที่ต้องการจองห้องประชุม') do
  sleep 1
  @booking.choose_date_for_booking
end

And('ฉันกดเลือกห้องที่ต้องการจอง') do
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

  # รีเซ็ตค่าการจอง
  @booking.reset_booking
end