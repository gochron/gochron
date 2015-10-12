class EventsController < ApplicationController

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_login_url # halts request cycle
    end
  end
   def index
     if params[:request_type ] == 'All'
	@events = Event.all 
    elsif params[:request_type] == 'MyEvents'
        @events = Event.where(:user_id => current_user.id)
    elsif params[:request_type] == 'Going'
        @events = Event.where(:user_id => current_user.id)
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

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
 
    redirect_to events_path
  end
end

