class ParticipantsController < ApplicationController

  def index
    event = Event.find(session[:event_id])
    @participants = event.users
  end

  def create
    event = Event.find(session[:event_id])
    assign_partners(event.roles)
    redirect_to event_participants_path
  end

  def assign_partners(participants)
    participant_ids = participants.map! { |participant| participant.user_id }
    participants.each do |participant|
      partner = participant_ids.sample
      if participant.user_id != partner
        participant.partner_id = partner
        participant.save
        participant_ids.delete(partner)
      else
        redo
      end
    end
  end
  
end