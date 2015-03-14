class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource_or_scope)
    root_path
  end

  def check_user_memberships
    events = current_user.memberships.map {|membership| membership.event_id}
    unless events.include? session[:event_id]
      redirect_to events_path
      Rails.logger.debug 'User does not have access to this event'
    end
  end
end
