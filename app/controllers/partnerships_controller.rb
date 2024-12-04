class PartnershipsController < ApplicationController
  before_action :get_event, only: [:index]

  def index
    @partnerships = @event.partnerships
  end
  
  def create
    event_id = params[:event_id]
    @event = Event.find event_id
    flash[:error] = 'You need at least two to tango.' and return if @event.users.count < 2

    @event.partnerships.delete_all if @event.partnerships.present?

    if AssignPartners.call(event_id)
      @event.partnerships.each do |partnership|
        NotificationMailer.partner_assignment_mail(partnership).deliver
      end
      flash[:notice] = 'High five! Partners have been assigned.'
    else
      flash[:error] = 'Bah humbug! Partners could not be assigned.'
    end

    redirect_to event_users_path
  end

end
