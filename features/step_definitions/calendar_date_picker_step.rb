And('ฉันเลือกวันที่ที่ต้องการจองห้องประชุม') do
  sleep 1
  @booking.click_tomorrow
end

Then('ฉันจะเห็นวันที่ที่เลือกไว้') do
  @booking.saw_selected_date
end