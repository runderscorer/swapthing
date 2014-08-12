class EventsController < ApplicationController
  def index
    @events = Event.all_by_user(current_user)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      @event = @event.roles.create(user_id: current_user.id, event_id: params[:event_id])
      redirect_to events_path
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(event_params)
      @event = @event.roles.create(user_id: current_user.id, event_id: params[:event_id])
      redirect_to events_path
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :description, :max_spend)
  end
end