class Oystercard

  attr_reader :balance

  MAX_VALUE = 90

  def initialize(balance = 0)
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
    @travel = true
  end

  def in_journey?
    @travel
  end

  def touch_out
    @travel = false
  end

end
