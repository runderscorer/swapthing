class AssignPartners
  def self.call(partnerships)
    # the rules are that every participant must have a partner
    # and that participants cannot be assigned to themselves
    participant_ids = partnerships.collect(&:giver_id).shuffle
    participant_ids << participant_ids.first

    pairs = participant_ids.each_cons 2

    pairs.each do |pair|
      partnerships.each do |partnership|
        if pair.first == partnership.giver_id
          partnership.getter_id = pair.last
          partnership.save!
        end
      end
    end
  end
end