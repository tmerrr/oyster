require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_reader :balance, :travel_history

  MAX_VALUE = 90
  MIN_FARE  = 1
  PENALTY   = 6

  def initialize(balance = MIN_FARE, journey_class = Journey)
    @balance = balance
    @travel_history = []
    @journey = journey_class.new(penalty: PENALTY, minimum_fare: MIN_FARE)
  end

  public

  def top_up(value)
    raise "max balance is #{MAX_VALUE}" if overloaded_by? value
    credit(value)
  end

  def touch_in(station)
    raise 'insufficient funds' if cannot_afford?
    # if previous journey wasn't completed, we should try to
    # complete it before we start changing journey state
    attempt_journey
    # now begin the new journey
    set_start(station)
  end

  def touch_out(station)
    # first mark the journey as having been completed
    set_end(station)
    # attempt to charge the user
    attempt_journey
  end

  def in_journey?
    @journey.in_journey?
  end

  private

  # changing balance

  def credit(value)
    @balance += value
  end

  def deduct(value)
    @balance -= value
  end

  # information about balance

  def overloaded_by?(value)
    @balance + value > MAX_VALUE
  end

  def cannot_afford?
    balance < MIN_FARE
  end

  # recording journeys

  def set_start(station)
    @journey.set_start(station)
  end

  def set_end(station)
    @journey.set_end(station)
  end

  def get_travel_history
    @travel_history << @journey.complete
  end

  def try_travel_history
    store_travel_history unless @journey.new_journey?
  end

  # journey fares and completion

  def attempt_journey
    deduct(fare)
    try_travel_history
  end

  def fare
    @journey.fare
  end
end
