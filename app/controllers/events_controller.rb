class EventsController < ApplicationController

  def index
    if params[:all] && params[:all] == "true"
      @events = Event.includes(:repeat_type).all
    else
      @events = current_user.events
    end
    render json: create_repeating_events
  end

  def create
    @event = Event.new
    @event.user = current_user
    @event.title = params[:event][:title]
    start = Date.new(params[:event]["start(1i)"].to_i, params[:event]["start(2i)"].to_i, params[:event]["start(3i)"].to_i)
    @event.start = start
    @event.repeat_type = RepeatType.find(params[:event][:repeat_type_id]) if params[:event][:repeat_type_id] != ""
    @event.save
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.user == current_user
      @event.title = params[:event][:title]
      start = Date.new(params[:event]["start(1i)"].to_i, params[:event]["start(2i)"].to_i, params[:event]["start(3i)"].to_i)
      @event.start = start
      if params[:event][:repeat_type_id] != ""
        @event.repeat_type = RepeatType.find(params[:event][:repeat_type_id])
      else
        @event.repeat_type = nil
      end
      @event.save
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.user == current_user
      @event.destroy
    end
  end

  def show
    render json: create_repeating_events
  end

  private
  def event_params
    params.require(:event).permit(:title, :start)
  end


  def create_repeating_events
    collection = []
    @events.each do |e|
      if e.repeat_type
        start_time = e.start - 5.years
        if e.repeat_type.title == "year"
          start_time_delta = 1.years
        elsif e.repeat_type.title == "day"
          start_time_delta = 1.days
        elsif e.repeat_type.title == "month"
          start_time_delta = 1.months
        elsif e.repeat_type.title == "week"
          start_time_delta = 1.weeks
        end
        if params[:all] && params[:all] == "true" && e.user==current_user
          while start_time <= e.start + 5.years
            collection+=
                [{
                     id: e.id,
                     start: start_time,
                     title: e.title,
                     color: "red"
                 }]
            start_time+=start_time_delta
          end
        else
          while start_time <= e.start + 5.years
            collection+=
                [{
                     id: e.id,
                     start: start_time,
                     title: e.title,
                 }]
            start_time+=start_time_delta
          end
        end
      else
        if params[:all] && params[:all] == "true" && e.user==current_user
          collection+=
              [{
                   id: e.id,
                   start: e.start,
                   title: e.title,
                   color: "red"
               }]
        else
          collection+=
              [{
                   id: e.id,
                   start: e.start,
                   title: e.title,
               }]
        end
      end
    end
    collection
  end
end

