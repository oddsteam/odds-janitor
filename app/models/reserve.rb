class Reserve < ApplicationRecord
  validates :date, :start_timer, :end_timer, :note, :roomId, presence: true
  validate :end_time_after_start_time

  def self.get_email_form_session(session)
    session[:user_email]
  end

  def self.get_userId_form_session(session)
    session[:user_id]
  end

  private

  def end_time_after_start_time
    return if end_timer.blank? || start_timer.blank?

    if end_timer <= start_timer
      errors.add(:end_timer, "must be after the start time")
    end
  end
end