class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def after_sign_in_path_for(resource_or_scope)
    if params[:event_id].present?
      CreateAdditionalMembership.call current_user.email, params[:event_id]
    end

    root_path
  end

  def get_user
    @user = current_user
  end

  def get_event
    if params[:event_id].present?
      @event = Event.find(params[:event_id]).decorate
    else
      @event = Event.find(params[:id])
    end
  end

  def admin_check
    id = params[:event_id] || params[:id]
    event = Event.find(id)
    redirect_to root_path unless event.admin == current_user
  end

  def valid_email_format email
    email.scan(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/).any?
  end
end
