class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    request_type = (params[:request_type].blank? || params[:request_type].length == 0) ? "AllEvents" : params[:request_type]
    current_cal  = (params[:current_cal].blank? || params[:current_cal].length == 0)  ? Date.today.to_s : params[:current_cal]

    d = Date.parse(current_cal)

    if request_type == "AllEvents"
      @events = Event.this_month(d) 

    elsif request_type == "Attending"
      @events = Event.where(:id.in => current_user.attending_event_ids).this_month(d)

    elsif request_type == "Subscribed"
      @events = Event.where(:id.in => current_user.subscribed_events.map(&:id)).this_month(d)

    end
  end
end
