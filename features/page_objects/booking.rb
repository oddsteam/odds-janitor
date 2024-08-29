class Booking
  include Capybara::DSL
  include RSpec::Matchers

  @@tomorrow = Date.today + 1
  @@tomorrow_booking_formatted = @@tomorrow.strftime('%Y-%m-%d')
  @@tomorrow_calendar_formatted = @@tomorrow.strftime("%A, %B #{@@tomorrow.day.ordinalize}, %Y")
  @@tomorrow_input_formatted = @@tomorrow.strftime("%a %d %B %Y")
  @@room_name_for_test = ('global')

  @@room_name_uppercase = @@room_name_for_test.upcase
  @@room_name_capitalize = @@room_name_for_test.capitalize

  def click_blueprint
    find('img[alt="Blueprint"]', wait:7).click
  end

  def saw_blueprint_detail
    expect(page).to have_selector('div[data-testid="modal-content"]', wait:7) # ถ้าเปลี่ยนเป็น rails แล้วรบกวนแก้ตัว data-testid ด้วยตอนนี้ใช้ตัวนี้เพื่อให้ test ได้อยู๋
    expect(page).to have_selector('svg', wait:7)
  end

  def click_room
    find("[data-testid='room-#{@@room_name_uppercase}']").click
  end

  def saw_highlight_color
    expect(find("[data-testid='room-#{@@room_name_uppercase}']")['class']).to include('bg-blue-400')
  end

  def saw_room_detail
    expect(page).to have_selector("img[alt='#{@@room_name_uppercase}']")
    expect(page).to have_selector("h1[data-testid='room-name-desktop']", text: @@room_name_uppercase)
  end

  def click_calendar
    # กดไอคอมปฏิทิน
    find('[data-icon="calendar-days"]').click
  end

  def click_tomorrow
    # เลือกวันที่
    find("[aria-label='Choose #{@@tomorrow_calendar_formatted}']").click
  end

  def saw_selected_date
    expect(page).to have_content(@@tomorrow_input_formatted)
  end

  def choose_date_for_booking
    click_calendar
    click_tomorrow
  end

  def choose_room_for_booking
    # เลือก <td> ที่มี data-hour="9" และ data-half="0"
    find(:xpath, "//tr[td[contains(text(), '#{@@room_name_capitalize}')]]/td[@data-hour='9' and @data-half='0']", wait:7).click
    # ตรวจสอบว่าหน้า modal ของห้อง Global แสดงขึ้นมา
    expect(page).to have_content("Reservation for #{@@room_name_capitalize}")
  end

  def fill_booking_detail
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
  end

  def confirm_booking
    # กดปุ่มยืนยันการจอง
    find('button[data-testid="confirm-button"]').click
  end

  def saw_booking_list
    # ตรวจสอบว่ามีรายการที่ได้ทำการจองไว้หรือไม่
    expect(page).to have_selector(:xpath, "//tr[td[contains(text(), '#{@@room_name_capitalize}')]]/td[@data-hour='8' and @data-half='0']/following-sibling::td[@colspan='4']", wait:7)
  end

  def dont_saw_booking_list
    expect(page).not_to have_selector(:xpath, "//tr[td[contains(text(), '#{@@room_name_capitalize}')]]/td[@data-hour='8' and @data-half='0']/following-sibling::td[@colspan='4']")
  end

  def click_my_booking
    find(:xpath, "//tr[td[contains(text(), '#{@@room_name_capitalize}')]]/td[@data-hour='8' and @data-half='0']/following-sibling::td[@colspan='4']", wait:7).click
  end

  def saw_booking_detail
    expect(page).to have_selector(:xpath, "//h3[text()='#{@@room_name_capitalize} · 08:30 - 10:30']", wait:7)
    expect(page).to have_xpath('//h3[text()="Date:"]/span', text: @@tomorrow_booking_formatted)
    expect(page).to have_xpath('//h3[text()="Booked by:"]/span', text: 'test user')
    expect(page).to have_xpath('//p[text()="Note:"]/span', text: 'Meeting with team')
  end

  def cancel_booking
    find(:xpath, '//button[text()="Cancel Booking"]', wait:7).click
  end

  def reset_booking
    # รีเซ็ตค่าการจอง
    click_my_booking
    cancel_booking
  end
end