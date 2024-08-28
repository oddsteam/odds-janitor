Then('ฉันจะเห็นรายละเอียดการจองห้องประชุมนี้') do
  @booking.saw_booking_detail

  # รีเซ็ตค่าการจอง
  @booking.cancel_booking
end