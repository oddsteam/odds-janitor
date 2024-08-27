Given('ฉันเปิดหน้าเข้าสู่ระบบ') do
  @lobby.visit_homepage
end

When('ฉันกรอก Email เป็น {string}') do |email|
  @lobby.fill_email(email)
end

And('ฉันกรอก Password เป็น {string}') do |password|
  @lobby.fill_password(password)
end

And('ฉันคลิกปุ่มเข้าสู่ระบบ') do
  @lobby.click_sign_in
end

Then('ฉันจะถูกนำไปยังหน้า Booking') do
  @lobby.saw_booking_page
end
