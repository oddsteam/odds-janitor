When('ฉันกดที่รูปปฏิทิน') do
  sleep 1
  find('[data-icon="calendar-days"]').click
end

And('ฉันเลือกวันที่ที่ต้องการจองห้องประชุม') do
  @tomorrow = Date.today + 1
  tomorrow_calendar_formatted = @tomorrow.strftime("%A, %B #{@tomorrow.day.ordinalize}, %Y")
  find("[aria-label='Choose #{tomorrow_calendar_formatted}']").click
end

Then('ฉันจะเห็นวันที่ที่เลือกไว้') do
  tomorrow_input_formatted = @tomorrow.strftime("%a %d %B %Y")
  expect(page).to have_content(tomorrow_input_formatted)
end