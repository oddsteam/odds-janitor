When('ฉันกดที่รูปปฏิทิน') do
  sleep 1
  @booking.click_calendar
end

And('ฉันเลือกวันที่ที่ต้องการจองห้องประชุม') do
  @booking.click_tomorrow
end

Then('ฉันจะเห็นวันที่ที่เลือกไว้') do
  @booking.saw_selected_date
end