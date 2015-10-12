class EventsController < ApplicationController
   def index
     @events = Event.all	
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

