class CalendarsController < ApplicationController
def index
	@public_event = Event.where(access_type:"public");
	@private_event = Event.where(access_type:"private");
	@closed_event = Event.where(access_type:"closed");
  end
end
