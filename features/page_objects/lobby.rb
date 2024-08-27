class Lobby
  include Capybara::DSL
  include RSpec::Matchers

  def visit_homepage
    visit 'https://janitor-dev.odds.team/'
  end

  def fill_email(email)
    fill_in 'username', with: email
  end

  def fill_password(password)
    fill_in 'password', with: password
  end

  def click_sign_in
    click_button 'Sign In'
  end

  def saw_booking_page
    expect(page).to have_selector('h1', text: 'Bookings')
  end

  def login
    fill_email('test@gmail.com')
    fill_password('test_password')
    click_sign_in
  end
end