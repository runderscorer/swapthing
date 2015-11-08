class GetPartner
  def self.call(user, event_id)
    partnerships = Event.find(event_id).partnerships
    return unless partnerships

    if partnerships.include? giver_id: user.id
      partner = partnerships.find_by(giver_id: user.id).getter
    else
      return nil
    end
  end
end