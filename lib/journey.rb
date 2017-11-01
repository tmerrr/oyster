class Journey
  attr_reader :start_point, :end_point

  def initialize(options = {})
    @penalty      = options[:penalty] || 0
    @min_fare     = options[:minimum_fare] || 0
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
    incurs_penalty? ? penalty_fare : standard_fare
  end

  def new_journey?
    @start_point.nil? && @end_point.nil?
  end

  private
  def refresh
    @start_point  = nil
    @end_point    = nil
  end

  def incurs_penalty?
    !!@start_point ^ !!@end_point
  end

  def standard_fare
    new_journey? ? 0 : @min_fare
  end

  def penalty_fare
    @penalty
  end
end
