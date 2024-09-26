class Reserve < ApplicationRecord
  
  validates :date, :start_timer, :end_timer, :room_id, presence: true
  validate :end_time_after_start_time
  validate :overlapping_time


  def self.get_email_form_session(session)
    session[:user_email]
  end

  def self.get_userId_form_session(session)
    session[:user_id]
  end

  private

  def end_time_after_start_time
    if end_timer <= start_timer
      errors.add(:end_timer, "must be after the start time")
    end
  end

  def overlapping_time
    testing = Reserve.where("date = ?", self.date)
                     .where("room_id = ?",self.room_id)
                     .where(
                        "(start_timer < ? AND end_timer > ?) OR (start_timer < ? AND end_timer > ?) OR (start_timer > ? AND end_timer < ?)", 
                        self.start_timer, self.start_timer, self.end_timer, self.end_timer, self.start_timer, self.end_timer
                      )             
    if testing.size > 0
        errors.add(:start_timer,"cannot be in between or cover any reservation")
        errors.add(:end_timer,"cannot be in between or cover any reservation")
    end
  end
end