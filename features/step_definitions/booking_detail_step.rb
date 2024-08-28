Then('ฉันจะเห็นชื่อห้องประชุมและเวลาของการจองนี้') do
  expect(page).to have_selector(:xpath, '//h3[text()="Global · 08:30 - 10:30"]', wait:5)
end

And('ฉันจะเห็นวันที่ของการจองนี้') do
  tomorrow = Date.today + 1
  tomorrow_booking_formatted = tomorrow.strftime('%Y-%m-%d')
  expect(page).to have_xpath('//h3[text()="Date:"]/span', text: tomorrow_booking_formatted)
end

And('ฉันจะเห็นชื่อของผู้จอง') do
  expect(page).to have_xpath('//h3[text()="Booked by:"]/span', text: 'test user')
end

And('ฉันจะเห็นรายละเอียดเพิ่มเติมของการจองนี้') do
  expect(page).to have_xpath('//p[text()="Note:"]/span', text: 'Meeting with team')

  # รีเซ็ตค่าการจอง
  find(:xpath, '//button[text()="Cancel Booking"]', wait:5).click
end