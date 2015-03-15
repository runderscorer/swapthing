class PartnershipsController < ApplicationController

  def index
    event = Event.find(session[:event_id])
    @participants = event.users
  end

  def create
    event = Event.find(session[:event_id])
    @participants = event.users

    @participants.each do |participant|
      Partnership.create(event_id: event.id, giver_id: participant.id)
    end

    assign_partners(event.partnerships)
    redirect_to event_partnerships_path
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