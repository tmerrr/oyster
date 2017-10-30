class Oystercard

  attr_reader :balance, :start_point, :travel_history

  MAX_VALUE = 90
  MIN_FARE = 1

  def initialize(balance = MIN_FARE)
    @balance = balance
    @travel_history = []
  end

  public
  def top_up(value)
    raise "Cannot exceed max balance of #{MAX_VALUE}" if (@balance + value > MAX_VALUE)
    @balance += value
  end

  def touch_in(station)
    fail 'Insufficient Funds' if (balance <= MIN_FARE)
    @start_point = station
  end

  def in_journey?
    @start_point != nil
  end

  def touch_out(station)
    @travel_history << {start_point: @start_point, end_point: station}
    deduct(MIN_FARE)
    @start_point = nil
  end

  private
  def deduct(value)
    @balance -= value
  end

end
