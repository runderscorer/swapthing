class EventsController < ApplicationController
  before_action :authenticate_user!
  around_action :check_user_memberships, except: [:index, :new, :create]
  before_action :get_event, only: [:show, :edit, :update]
  before_action :admin_check, only: [:edit]
  before_action :clear_event_session, only: [:index]
  
  def index
    @events = Event.all_by_user(current_user)
  end

  def new
    @event = Event.new
  end

  def show
    @current_user = current_user.decorate
    # @partner = GetPartner.call current_user, @event
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      Membership.create(user_id: current_user.id, event_id: @event.id)
      redirect_to events_path
    end
  end

  def edit
  end

  def update
    if @event.update_attributes(event_params)
      redirect_to events_path
    end
  end

  def destroy
    @event = Event.find(params[:id])
    memberships = Membership.where(event_id: @event.id).each {|membership| membership.destroy}
    @event.destroy
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :description, :max_spend)
  end

  def check_user_memberships
    accessible_events = current_user.memberships.map {|membership| membership.event_id}
    if accessible_events.include? params[:id].to_i
      yield
    else
      redirect_to events_path
      Rails.logger.debug 'User does not have access to this event'
    end
  end

  def clear_event_session
    session[:event_id].delete if session[:event_id].present?
  end
end