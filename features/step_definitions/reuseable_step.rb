Given('ฉันเข้าสู่ระบบแล้ว') do
  @lobby.visit_homepage
  @lobby.login
end

And('ฉันทำการจองแล้ว') do
  @tomorrow = Date.today + 1
  tomorrow_calendar_formatted = @tomorrow.strftime("%A, %B #{@tomorrow.day.ordinalize}, %Y")
  sleep 1
  # กดไอคอมปฏิทิน
  find('[data-icon="calendar-days"]').click
  # เลือกวันที่
  find("[aria-label='Choose #{tomorrow_calendar_formatted}']").click
  # เลือก <td> ที่มี data-hour="9" และ data-half="0"
  find(:xpath, '//tr[td[contains(text(), "Global")]]/td[@data-hour="9" and @data-half="0"]', wait:5).click
  # ตรวจสอบว่าหน้า modal ของห้อง Global แสดงขึ้นมา
  expect(page).to have_content('Reservation for Global')
  # กดปุ่มที่มีคำว่า "9:00"
  find('button', text: '9:00').click
  # เลือกเวลาเริ่มต้น คือ 8:30
  find(:xpath, '//button[text()="9:00"]/following-sibling::div/div[text()="8:30"]').click
  # กดปุ่มที่มีคำว่า "9:30"
  find('button', text: '9:30').click
  # เลือกเวลาสิ้นสุดคือ คือ 8:30
  find(:xpath, '//button[text()="9:30"]/following-sibling::div/div[text()="10:30"]').click
  # กรอกคำอธิบายเพิ่มเติม
  find('textarea#reservation').set('Meeting with team')
  # กดยืนยันการจอง
  find('button[data-testid="confirm-button"]').click
  # ตรวจสอบว่ามีรายการที่ได้ทำการจองไว้หรือไม่
  expect(page).to have_selector(:xpath, '//tr[td[contains(text(), "Global")]]/td[@data-hour="8" and @data-half="0"]/following-sibling::td[@colspan="4"]', wait:5)
end

When('ฉันกดดูรายการจองของฉัน') do
  find(:xpath, '//tr[td[contains(text(), "Global")]]/td[@data-hour="8" and @data-half="0"]/following-sibling::td[@colspan="4"]', wait:5).click
end