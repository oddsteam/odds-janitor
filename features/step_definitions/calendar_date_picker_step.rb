And('ฉันเลือกวันพรุ่งนี้ในปฏิทิน') do
  sleep 1
  @booking.click_tomorrow
end

Then('ฉันจะเห็นวันที่ที่เลือกไว้') do
  @booking.saw_selected_date
end

And('ฉันเลือกวันในอดีต') do
  @booking.click_yesterday
end

Then('ฉันไม่สามารถเลือกวันในอดีตได้') do
  @booking.don_saw_selected_date
end