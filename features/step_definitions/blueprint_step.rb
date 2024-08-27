When('ฉันกดที่รูปแผนผังออฟฟิศ') do
  @booking.click_blueprint
end

Then('ฉันจะเห็นแผนผังของออฟฟิศแบบขยาย') do
  @booking.saw_blueprint_detail
end