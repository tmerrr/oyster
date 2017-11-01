class Journey
  attr_reader :start_point, :end_point

  def initialize
    @start_point  = nil
    @end_point    = nil
  end

  def start(station)
    @start_point = { station: station.name, zone: station.zone }
  end

  def finish(station)
    @end_point = { station: station.name, zone: station.zone }
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

  def penalty?

  end

  def at_touch_in?
    @start_point.nil? && @end_point.nil?
  end

  def incomplete_journey?
    @start_point || @end_point
  end

  def improper_start
    in_journey? && at_touch_in?
  end

  def improper_end

  end

end
