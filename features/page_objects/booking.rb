class Booking
  include Capybara::DSL
  include RSpec::Matchers

  def click_blueprint
    find('img[alt="Blueprint"]').click
  end

  def saw_blueprint_detail
    expect(page).to have_selector('div[data-testid="modal-content"]') # ถ้าเปลี่ยนเป็น rails แล้วรบกวนแก้ตัว data-testid ด้วยตอนนี้ใช้ตัวนี้เพื่อให้ test ได้อยู๋
    expect(page).to have_selector('svg')
  end

  def click_global_room
    find('[data-testid="room-GLOBAL"]').click
  end

  def saw_highlight_color
    expect(find('[data-testid="room-GLOBAL"]')['class']).to include('bg-blue-400')
  end

  def saw_room_detail
    expect(page).to have_selector("img[alt='GLOBAL']")
    expect(page).to have_selector("h1[data-testid='room-name-desktop']", text: 'GLOBAL')
  end
end