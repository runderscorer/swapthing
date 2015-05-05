class PartnerService

  def initialize(partnerships)
    @partnerships = partnerships
    @event = Event.find partnerships.collect(&:event_id).uniq
    @givers = partnerships.collect(&:giver_id)
  end

  def assign
    begin
      participant_ids = @partnerships.map { |partnership| partnership.giver_id }
      @partnerships.each do |partnership|
        getter = participant_ids.sample
        partnership.getter_id = getter
        if partnership.getter_id != partnership.giver_id
          partnership.save
          participant_ids.delete(getter)
        else
          redo
        end
      end
    rescue
      retry
    end
  end

end