class HomeController < ApplicationController
  before_action :authenticate_user!
 helper_method :is_active?

def is_active?(page_name)
        if params[:request_type] == page_name
        "btn btn-default active"
        elsif params[:request_type] != page_name
        "btn btn-info"
        end
   end

  def index
    @public_event = Event.order_by(datetime: 'asc')#where(access_type:"public");
    # @private_event = Event.where(access_type:"private");
    # @closed_event = Event.where(access_type:"closed");
    @event = Event.all;
    @event_by_date = {} # { "2015-10-16" => [ Event, Event, Event ], "2015-10-17" => [Event] ... }
    @event.each do |e|
      d = e.datetime.to_date.to_s
      if @event_by_date[d].blank?
        @event_by_date[d] = [e]
      else
        @event_by_date[d] << e
      end
    end

    # @event_by_date = @event.group_by(&:datetime);
    @date = params[:date] ? Date.parse(params[:date]) : Date.today;
  end
end
