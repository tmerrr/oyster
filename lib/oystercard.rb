class Oystercard

  attr_reader :balance

  MAX_VALUE = 90
  MIN_FARE = 1

  def initialize(balance = MIN_FARE)
    @balance = balance
    @travel = false
  end

  public
  def top_up(value)
    raise "Cannot exceed max balance of #{MAX_VALUE}" if (@balance + value > MAX_VALUE)
    @balance += value
  end

  def touch_in
    fail 'Insufficient Funds' if (balance <= MIN_FARE)
    @travel = true
  end

  def in_journey?
    @travel
  end

  def touch_out
    @travel = false
    deduct(MIN_FARE)
  end

  private
  def deduct(value)
    @balance -= value
  end

end
