When('ฉันกดที่ชื่อห้องประชุม') do
  sleep 1
  @booking.click_global_room
end

Then('ปุ่มชื่อห้องประชุมนั้นจะเปลี่ยนสี') do
  sleep 1
  @booking.saw_highlight_color
end

And('ฉันจะเห็นรายละเอียดของห้องประชุม') do
  @booking.saw_room_detail
end