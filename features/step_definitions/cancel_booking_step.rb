When('ฉันกดยกเลิกการจอง') do
  find(:xpath, '//button[text()="Cancel Booking"]', wait:5).click
end

Then('ฉันจะไม่เห็นรายการจองที่ได้ทำการยกเลิกไปแล้ว') do
  expect(page).not_to have_selector(:xpath, '//tr[td[contains(text(), "Global")]]/td[@data-hour="8" and @data-half="0"]/following-sibling::td[@colspan="4"]', wait:5)
end