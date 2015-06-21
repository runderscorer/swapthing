class GetPartner
  def self.call(user, event_id)
    return unless Event.find(event_id).partnerships.present?
    partnership = Partnership.find_by(event_id: event_id, giver_id: user.id).getter
  end
end