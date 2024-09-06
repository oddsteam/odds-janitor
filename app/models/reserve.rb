class Reserve < ApplicationRecord
  def self.get_email_form_session(session)
    session[:user_email]
  end
  def self.get_userId_form_session(session)
    session[:user_id]
  end
end
