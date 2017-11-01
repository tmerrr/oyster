require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_reader :balance, :travel_history

  MAX_VALUE = 90
  MIN_FARE  = 1
  PENALTY   = 6

  def initialize(balance = MIN_FARE)
    @balance        = balance
    @travel_history = []
    @journey        = Journey.new(penalty: PENALTY, min_fare: MIN_FARE)
  end

  public
  def top_up(value)
    raise "Max Balance of #{MAX_VALUE}" if (@balance + value > MAX_VALUE)
    @balance += value
    "You have successfully topped up your Oystercard by £#{value}"
  end

  def touch_in(station)
    fail 'Insufficient Funds' if (balance < MIN_FARE)
    complete
    @journey.set_start(station)
    'Have a good journey!'
  end

  def touch_out(station)
    @journey.set_end(station)
    complete
    'Thank you, goodbye!'
  end

  def in_journey?
    @journey.in_journey?
  end

  def my_start_point
    @journey.start_point
  end

  private

  def complete
    deduct(fare)
    add_travel_history
  end

  def add_travel_history
    store_travel_history unless @journey.completed?
  end

  def fare
    @journey.fare
  end

  def deduct(value)
    @balance -= value
  end

  def store_travel_history
    @travel_history << @journey.complete
  end

  def start_zone
    @journey.start_point[:zone]
  end

  def end_zone
    @journey.end_point[:zone]
  end

end
