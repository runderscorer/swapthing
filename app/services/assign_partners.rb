class AssignPartners

  def self.call(partnerships)
    begin
      @partnerships = partnerships
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