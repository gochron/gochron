class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @public_event = Event.order_by(datetime: 'asc')#where(access_type:"public");
    # @private_event = Event.where(access_type:"private");
    # @closed_event = Event.where(access_type:"closed");
    @event = Event.all;
    @event_by_date = @event.group_by(&:datetime);
    @date = params[:date] ? Date.parse(params[:date]) : Date.today;
  end
end
