When('ฉันกดยกเลิกการจอง') do
  @booking.cancel_booking
end

Then('ฉันจะไม่เห็นรายการจองที่ได้ทำการยกเลิกไปแล้ว') do
  sleep 2
  @booking.dont_saw_booking_bar
end