class UsersController < ApplicationController
  before_action :get_event

  def index
    @users = @event.users
  end

  private

  def get_event
    @event = Event.find(params[:event_id])
  end
end