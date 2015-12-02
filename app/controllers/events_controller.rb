class EventsController < ApplicationController
   before_action :authenticate_user!

   def index
    request_type = (params[:request_type].blank? || params[:request_type].length == 0) ? "AllEvents" : params[:request_type]

    if params[:search]
	    search = params[:search]
      @events = Event.any_of({ :title => /.*#{search}.*/i })

    elsif request_type == 'AllEvents'
	    @events = Event.all

    elsif request_type == 'Subscribed'
      @events = current_user.subscribed_events

   elsif request_type == 'Attending'
      @events = current_user.attending_events

    elsif request_type == 'MyCreated'
      @events = current_user.events

    end
   end

   def new
     @event = Event.new
   end
   
   def edit
     @event = Event.find(params[:id]) 
   end
  
   def show
     @event = Event.find(params[:id])	
   end

   def create
     @event = Event.new(params[:event].permit(:title,:access_type,:description,:location,:datetime,:link,:image_attachment))
     @event.user_id = current_user.id
     # @event.attendee_ids << current_user.id	
     @event.group_id = params[:event][:group_id] if params[:event][:group_id]

     if @event.save
     #! Notify users about new events in subscribed groups 
      if @event.group_id.present? 
         @event.group.subscriber_ids.each do |n|
           @notify = Notification.create({user_id: n, event_id: @event.id.to_s, title: @event.title, seen: false})
         end  
      end   
       redirect_to @event
     else
       render 'new' 
     end
   end

  def update
    @event = Event.find(params[:id])

    if request.xhr?
      if (@event.user_id.to_s == params[:user_id].to_s) && (@event.update(params[:event].permit(:title,:description,:location,:datetime,:link)))
        render text: "true" and return
      else
        render text: "false" and return
      end
    end

    #!Facebook like notification when an event is updated for all its attendees
    @prev_event = @event.title
    if @event.update((params[:event].permit(:event_id,:title,:access_type,:description,:location,:datetime,:link)))
      @event.attendee_ids.each do |n|
        @notify = Notification.create({user_id: n, event_id: @event.id.to_s, title: @prev_event, seen: false})
      end
      redirect_to @event
    else
      render 'edit'
    end
  end

  # Join or remove attend status of user for an event
  # User can add an event of any group. Subscription to that group is not necessary.
  def attend
    @event = Event.find(params[:id])

    if params[:perform] == 'Join'
      current_user.attending_events << @event
      @event.attendees << current_user

      #!Send Email an hour before the event starts for all its attendees
      user_id = current_user.id.to_s
      event_id = @event.id.to_s
      t = Time.zone.parse((@event.datetime).to_s)
      AlertsWorker.perform_in((t - Time.now - 1.hour).hour, user_id, event_id)
      #AttendeeMailer.delay_for(2.minutes.from_now).notify_attendee(current_user,@event)
      #AttendeeMailer.notify_attendee(current_user, @event).deliver_now

    elsif params[:perform] == 'Remove'
      current_user.attending_event_ids.delete(@event.id)
      @event.attendee_ids.delete(current_user.id)
    end

    current_user.save!
    @event.save!

    redirect_to request.referrer
  end

  def set_notifs_seen
    if request.xhr?
      if current_user
        Notification.where(user_id: current_user.id, seen: false).update_all(seen: true)
        render text: "true" and return
      end
    end

    render text: "false"
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
 
    redirect_to events_path
  end
end
