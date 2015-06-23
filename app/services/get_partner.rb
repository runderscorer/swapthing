class GetPartner
  def self.call(user, event_id)
    if Event.find(event_id).partnerships.present?
      Partnership.find_by(event_id: event_id, giver_id: user.id).getter
    end
  end
end