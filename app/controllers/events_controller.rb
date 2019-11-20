class EventsController < ApplicationController
  before_action :authenticate_user!
  around_action :check_user_memberships, except: [:index, :new, :create]
  before_action :get_event, only: [:show, :edit, :update]
  before_action :admin_check, only: [:edit]
  before_action :format_date, only: [:create, :update]
  before_action :clear_event_session, only: [:index]

  def index
    @events = Event.all_by_user(current_user)
  end

  def new
    @event = Event.new
  end

  def show
    @current_user = current_user.decorate
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      Membership.create(user_id: current_user.id, event_id: @event.id)
      flash[:notice] = 'Great! Your event has been saved.'
      redirect_to events_path
    else
      flash.now[:error] = 'Your event was not saved. Please review the errors below.'
      render :new
    end
  end

  def edit
  end

  def update
    if @event.update_attributes(event_params)
      flash[:notice] = 'Great! Your event has been updated.'
      redirect_to events_path
    else
      flash[:error] = 'Your event was not updated. Please review the errors below.'
      render :edit
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
    params.require(:event).permit(:name, :date, :description, :max_spend, :admin_id)
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

  def format_date
    params[:event][:date] = Date.strptime(event_params[:date], '%m/%d/%y') unless params[:event][:date].blank?
  end
end
