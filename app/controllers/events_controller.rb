class EventsController < ApplicationController
before_action :authenticate_user!
   def index
    if params[:search]
	search = params[:search]
      @events = Event.any_of({ :title => /.*#{search}.*/ })
    elsif params[:request_type ] == 'All'
	@events = Event.all 
    elsif params[:request_type] == 'MyEvents'
        @events = Event.where(:user_id => current_user.id)
    elsif params[:request_type] == 'Going'
        @events = Event.where(:id.in => current_user.attending_event_ids)
    elsif params[:request_type] == 'Subscribed'
        @events = Event.where(:user_id => current_user.id)
    else
        @events = Event.where(:user_id => current_user.id)	
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

  def attend
    @event = Event.find(params[:id]) 
    if params[:request_type ] == 'Join'
        @event.attendee_ids << current_user.id
    elsif params[:request_type] == 'Remove'
       @event.attendee_ids.delete(current_user.id)
    end	
    @event.save
    redirect_to events_path
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
 
    redirect_to events_path
  end
end
