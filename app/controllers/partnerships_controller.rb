class PartnershipsController < ApplicationController

  def create
    event = Event.find(session[:event_id])
    participants = event.users

    if event.partnerships.blank?
      partnerships = participants.map! do |participant|
        Partnership.new(event_id: event.id, giver_id: participant.id)
      end
    else
      partnerships = event.partnerships
    end

    AssignPartners.call(partnerships)
    partnerships.each do |partnership|
      NotificationMailer.partner_assignment_mail(partnership).deliver
    end

    redirect_to event_users_path
  end

end