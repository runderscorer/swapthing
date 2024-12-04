class AssignPartners
  def self.call(event_id, attempts = 0)
    return false if attempts > 5

    event = Event.find event_id
    users = event.users

    exclusions = users.each_with_object({}) do |user, hash|
      hash[user.id] = user.exclusion.excluded_user_id if user.has_exclusion?
    end

    users = users.shuffle

    assigned = Set.new
    
    users.each do |user|
      partner = users.find do |u|
        u.id != user.id && u.id != exclusions[user.id] && !assigned.include?(u.id)
      end

      if partner
        assigned.add(partner.id)
        Partnership.create!(event_id: event_id, giver_id: user.id, getter_id: partner.id)
      else
        event.partnerships.destroy_all
        AssignPartners.call(event_id, attempts + 1)
      end
    end
  end
end