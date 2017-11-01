class Journey
  attr_reader :start_point, :end_point

  def initialize(options = {})
    @penalty      = options[:penalty] || 0
    @min_fare     = options[:min_fare] || 0
    @start_point  = options[:start_point]
    @end_point    = options[:end_point]
  end

  def set_start(station)
    @start_point = { station: station.name, zone: station.zone }
  end

  def set_end(station)
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

  def fare
    penalty? ? penalty_fare : standard_fare
  end

  def completed?
    @start_point.nil? && @end_point.nil?
  end

  private
  def refresh
    @start_point  = nil
    @end_point    = nil
  end

  def penalty?
    !!@start_point ^ !!@end_point
  end

  def standard_fare
    completed? ? 0 : @min_fare
  end

  def penalty_fare
    @penalty
  end

end
