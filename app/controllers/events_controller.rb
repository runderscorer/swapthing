class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = Event.all_by_user(current_user)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      Role.create(user_id: current_user.id, event_id: @event.id)
      redirect_to events_path
    end
  end

  def edit
    @event = Event.find(params[:id])
    session[:event_id] = @event.id
  end

  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(event_params)
      redirect_to events_path
    end
  end

  def destroy
    @event = Event.find(params[:id])
    roles = Role.where(event_id: @event.id).each {|role| role.destroy}
    @event.destroy
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :description, :max_spend)
  end
end