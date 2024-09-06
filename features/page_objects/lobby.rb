class Lobby
  include Capybara::DSL
  include RSpec::Matchers

  def visit_homepage
    visit "https://sso-dev.odd.works/realms/janitor-dev/protocol/openid-connect/auth?client_id=janitor-dev&redirect_uri=http://localhost:3000/callback&response_type=code&scope=openid"
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
    expect(page).to have_selector('h1', text: 'Rooms Reserves')
  end

  def login
    fill_email('test@gmail.com')
    fill_password('test_password')
    click_sign_in
  end
end