class EventsController < ApplicationController
   def index

   end

   def new

   end

   def show
     @event = Event.find(params[:id])	
   end

   def create
     @event = Event.new(params[:event].permit(:title,:access_type,:description,:location,:datetime,:link))
     @event.save
     redirect_to @event
   end
end
