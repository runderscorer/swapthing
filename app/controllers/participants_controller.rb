class ParticipantsController < ApplicationController

  def index
    event = Event.find(session[:event_id])
    @participants = event.users
  end

end