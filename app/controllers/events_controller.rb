# TODO:
# Pagination on all pages
# Comment box under every event (like FB)
# Share event on social sites fb/twitter/gplus

class EventsController < ApplicationController
   before_action :authenticate_user!

   def index
    if params[:search]
	    search = params[:search]
      @events = Event.any_of({ :title => /.*#{search}.*/i })

    elsif params[:request_type ] == 'All'
	    @events = Event.all

    elsif params[:request_type] == 'MyEvents'
      @events = current_user.events

    elsif params[:request_type] == 'Attending'
      @events = current_user.attending_events

    elsif params[:request_type] == 'Subscribed'
      @events = current_user.subscribed_events

    else
      @events = current_user.events # default

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
     @event = Event.new(params[:event].permit(:title,:access_type,:description,:location,:datetime,:link))
     @event.user_id = current_user.id
     @event.attendee_ids << current_user.id	
     if @event.save
       redirect_to @event
     else
       render 'new' 
     end
   end

  def update
    @event = Event.find(params[:id])
    if @event.update((params[:event].permit(:title,:access_type,:description,:location,:datetime,:link)))
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

    redirect_to events_path(request_type: params[:request_type])
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
 
    redirect_to events_path
  end
end
