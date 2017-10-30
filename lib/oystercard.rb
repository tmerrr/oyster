class Oystercard

  attr_reader :balance

  MAX_VALUE = 90

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(value)
    raise "Cannot exceed max balance of #{MAX_VALUE}" if (@balance + value > MAX_VALUE)
    @balance += value
  end

end
