class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def after_sign_in_path_for(resource_or_scope)
    root_path
  end

  def get_user
    @user = current_user
  end

  def get_event
    if params[:event_id].present?
      @event = Event.find(params[:event_id])
    else
      @event = Event.find(params[:id])
    end
  end
end
