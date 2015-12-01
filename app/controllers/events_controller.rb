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
     @event = Event.new(params[:event].permit(:title,:description,:location,:datetime,:link))
     @event.user_id = current_user.id
     @event.attendee_ids << current_user.id	
     @event.group_id = params[:event][:group_id] if params[:event][:group_id]
     if @event.save
       redirect_to @event
     else
       render 'new' 
     end
   end

  def update
    @event = Event.find(params[:id])

    # ajax request called from /home/index
    if request.xhr?
      if (@event.user_id.to_s == params[:user_id].to_s) && (@event.update(params[:event].permit(:title,:description,:location,:datetime,:link)))
        render text: "true" and return
      else
        render text: "false" and return
      end
    end

    if @event.update((params[:event].permit(:title,:description,:location,:datetime,:link)))
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

    elsif params[:perform] == 'Remove'
      current_user.attending_event_ids.delete(@event.id)
      @event.attendee_ids.delete(current_user.id)
    end

    current_user.save!
    @event.save!

    redirect_to request.referrer
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
 
    redirect_to events_path
  end
end
