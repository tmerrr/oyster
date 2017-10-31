class Journey

  def initialize
    @start_point = nil
  end

  def start(station)
    @start_point = station.name
  end

  def in_journey?
    @start_point != nil
  end

end
