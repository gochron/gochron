# Preview all emails at http://localhost:3000/rails/mailers/attendee_mailer
class AttendeeMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/attendee_mailer/notify_attendee
  def notify_attendee
    AttendeeMailer.notify_attendee
  end

end
