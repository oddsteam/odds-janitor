And('ฉันเลือกวันที่ที่ต้องการจองห้องประชุม') do
  sleep 1
  @booking.click_tomorrow
end

Then('ฉันจะเห็นวันที่ที่เลือกไว้') do
  @booking.saw_selected_date
end

And('ฉันเลือกห้องที่ต้องการจองในอดีต') do
  @booking.click_yesterday
end

Then('ฉันจะไม่เห็นข้อมูลเมื่อวาน') do
  @booking.don_saw_selected_date
end