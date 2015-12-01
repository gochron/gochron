class AlertsWorker
  include Sidekiq::Worker

  def perform(user_id, event_id)
    logger.debug("[INSIDE ALERTS-WORKER] Sending Email ... user_id -> #{user_id}, event_id -> #{event_id}")
    
    user = User.find(user_id)
    event = Event.find(event_id)

    logger.debug(user)
    logger.debug(event)
    AttendeeMailer.notify_attendee(user, event).deliver_now    
  end
end