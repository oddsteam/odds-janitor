class Booking
  include Capybara::DSL
  include RSpec::Matchers

  @@tomorrow = Date.today + 1
  @@tomorrow_booking_formatted = @@tomorrow.strftime('%Y-%m-%d')
  @@tomorrow_calendar_formatted = @@tomorrow.strftime("%A, %B #{@@tomorrow.day.ordinalize}, %Y")
  @@day_tomorrow = (Date.today + 1).strftime("%B %d, %Y")
  @@tomorrow_input_formatted = @@tomorrow.strftime("%a %-d %B %Y")
  @@room_name_for_test = ('Global')
  @@room_index = 1

  def click_blueprint
    find('img[alt="Blueprint"]', wait:7).click
  end

  def saw_blueprint_detail
    expect(page).to have_selector('div[data-testid="modal-content"]', wait:7) # ถ้าเปลี่ยนเป็น rails แล้วรบกวนแก้ตัว data-testid ด้วยตอนนี้ใช้ตัวนี้เพื่อให้ test ได้อยู๋
    expect(page).to have_selector('svg', wait:7)
  end

  def click_room
    find("[data-testid='room-#{@@room_name_for_test}']").click
  end

  def saw_highlight_color
    expect(find("[data-testid='room-#{@@room_name_for_test}']")['class']).to include('bg-blue-400')
  end

  def saw_room_detail
    expect(page).to have_selector("img[alt='#{@@room_name_for_test}']")
    expect(page).to have_selector("h1[data-testid='room-name-desktop']", text: @@room_name_for_test)
  end

  def click_tomorrow
    find("button[data-date='#{(Date.today + 1).to_s}']").click
  end

  def click_yesterday
    find("button[data-date='#{(Date.today - 1).to_s}']").click
  end

  def saw_selected_date
    expect(page).to have_content("Your booking on #{@@day_tomorrow}")
  end

  def don_saw_selected_date
    expect(page).not_to have_content("Your booking on #{@@day_tomorrow}")
  end

  def choose_date_for_booking
    click_tomorrow
  end

  def choose_room_for_booking
    # เลือก <td> ที่มี data-hour="9" และ data-half="0"
    find(:xpath, "//div[@data-room-id='#{@@room_index}' and @data-start-time='08:00' and @class='timeCell border-[0.5px] border-slate-100 w-14 h-14']", wait: 7).click
    select '08:00', from: 'reserve_start_timer'
    select '12:00', from: 'reserve_end_timer'
    sleep 3

    # ตรวจสอบว่าหน้า modal ของห้อง Global แสดงขึ้นมา
    expect(page).to have_content("Reserve Time")
  end

  def fill_booking_detail
    fill_in 'reserve_note', with: 'This is a test reservation note'
  end

  def confirm_booking
    click_button name: 'commit'
  end

  def saw_booking_bar
    expect(page).to have_selector(:xpath, "//div[@data-room-id='1' and @data-start-time='08:00' and @data-end-time='12:00']", wait:7)
  end

  def dont_saw_booking_list
    expect(page).not_to have_selector(:xpath, "//tr[td[contains(text(), '#{@@room_name_for_test}')]]/td[@data-hour='8' and @data-half='0']/following-sibling::td[@colspan='4']")
  end

  def click_my_booking
    find(:xpath, "//tr[td[contains(text(), '#{@@room_name_for_test}')]]/td[@data-hour='8' and @data-half='0']/following-sibling::td[@colspan='4']", wait:7).click
  end

  def saw_booking_detail
    expect(page).to have_selector(:xpath, "//h3[text()='#{@@room_name_for_test} · 08:30 - 10:30']", wait:7)
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