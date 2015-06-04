class PartnershipsController < ApplicationController
  before_filter :get_event

  def create
    participants = @event.users

    if @event.partnerships.blank?
      partnerships = participants.map! do |participant|
        Partnership.new(event_id: @event.id, giver_id: participant.id)
      end
    else
      partnerships = @event.partnerships
    end

    AssignPartners.call(partnerships)
    partnerships.each do |partnership|
      NotificationMailer.partner_assignment_mail(partnership).deliver
    end

    redirect_to event_users_path
  end

end