class PartnershipsController < ApplicationController

  def index
    event = Event.find(session[:event_id])
    @participants = event.users
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

    assign_partners(partnerships)
    redirect_to event_partnerships_path
  end

  def assign_partners(participants)
    begin
      participant_ids = participants.map { |participant| participant.giver_id }
      participants.each do |participant|
        getter = participant_ids.sample
        participant.getter_id = getter
        if participant.getter_id != participant.giver_id
          participant.save
          participant_ids.delete(getter)
        else
          redo
        end
      end
    rescue
    end
  end

end