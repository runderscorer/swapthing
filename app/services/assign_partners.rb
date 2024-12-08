class AssignPartners
  def self.call(event_id, attempts = 0)
    return false if attempts > 5

    event = Event.find(event_id)
    givers = event.users

    return false if givers.count < 2

    getters = Set.new

    givers.each do |giver|
      getter = givers.sample

      while getter == giver || getters.include?(getter) || giver.exclusion&.excluded_user_id == getter.id
        getter = givers.sample
      end

      getters.add(getter)

      Partnership.create!(giver_id: giver.id, getter_id: getter.id, event_id: event_id)
    end

    if event.partnerships.count != givers.count
      event.partnerships.destroy_all
      AssignPartners.call(event_id, attempts + 1)
    end

    true
  end
end