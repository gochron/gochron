class AttendeeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.attendee_mailer.notify_attendee.subject
  #
  def notify_attendee(current_user, event)
    @current_user = current_user
    @event = event
     
    logger.debug("[INSIDE NOTIFY ATTENDEE] In attendee Mailer Controller")
    mail to: current_user.email, subject: "Event Notification"
  end
end
