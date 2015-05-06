class PartnershipsController < ApplicationController

  def index
    @event = Event.find(session[:event_id])
    @participants = @event.users
  end

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
    
    redirect_to event_partnerships_path
  end

end