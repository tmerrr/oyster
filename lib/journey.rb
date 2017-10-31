class Journey
  attr_reader :start_point, :end_point

  def initialize
    @start_point  = nil
    @end_point    = nil
  end

  def start(station)
    @start_point = station.name
  end

  def finish(station)
    @end_point = station.name
  end

  def in_journey?
    @start_point != nil
  end

  def complete
    complete_journey = {date: Time.now, start: @start_point, finish: @end_point }
    refresh
    complete_journey
  end

  private
  def refresh
    @start_point  = nil
    @end_point    = nil
  end

end
