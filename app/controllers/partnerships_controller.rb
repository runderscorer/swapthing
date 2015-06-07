class PartnershipsController < ApplicationController
  before_filter :get_event

  def create
    participants = @event.users
    @event.partnerships.delete_all if @event.partnerships.present?

    partnerships = @event.users.map! {|user| @event.partnerships.new(giver_id: user.id)}

    AssignPartners.call(partnerships)

    partnerships.each do |partnership|
      NotificationMailer.partner_assignment_mail(partnership).deliver
    end
    redirect_to event_users_path
  end

end