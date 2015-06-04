class PartnershipsController < ApplicationController
  before_filter :get_event

  def create
    participants = @event.users

    @event.partnerships.delete_all if @event.partnerships.present?

    partnerships = participants.map! do |participant|
      Partnership.new(event_id: @event.id, giver_id: participant.id)
    end

    AssignPartners.call(partnerships)
    partnerships.each do |partnership|
      NotificationMailer.partner_assignment_mail(partnership).deliver
    end

    redirect_to event_users_path
  end

end