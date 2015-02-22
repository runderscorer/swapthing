class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_invite_path_for(resource_name)
    new_user_invitation_path
  end

  def check_user_roles
    events = current_user.roles.map {|role| Event.find(role.event_id)}
    binding.pry
  end
end
