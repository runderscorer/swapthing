class ParticipantsController < ApplicationController

  def index
    event = Event.find(session[:event_id])
    @participants = event.users
  end

  def create
    event = Event.find(session[:event_id])
    assign_partners(event.partnerships)
    redirect_to event_participants_path
  end

  def assign_partners(participants)
    participant_ids = participants.map! { |participant| participant.giver_id }
    begin
      participants.each do |participant|
        getter = participant_ids.sample
          participant.getter_id = getter
          participant.save
          participant_ids.delete(getter)
      end
    rescue
    end
  end

end