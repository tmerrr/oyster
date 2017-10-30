class Oystercard

  attr_reader :balance

  MAX_VALUE = 90
  MIN_VALUE = 1

  def initialize(balance = MIN_VALUE)
    @balance = balance
    @travel = false
  end

  def top_up(value)
    raise "Cannot exceed max balance of #{MAX_VALUE}" if (@balance + value > MAX_VALUE)
    @balance += value
  end

  def deduct(value)
    @balance -= value
  end

  def touch_in
    fail 'Insufficient Funds' if (balance <= MIN_VALUE)
    @travel = true
  end

  def in_journey?
    @travel
  end

  def touch_out
    @travel = false
  end

end
