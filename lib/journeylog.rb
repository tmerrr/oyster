require_relative 'journey.rb'
require_relative 'status.rb'

class JourneyLog

  attr_reader :journey_class, :status, :journeys

  public

  def initialize(journey_class: Journey, status_class: Status)
    @journey_class = journey_class
    @status = status_class.new
    @journeys = []
  end

  def start_journey(station)
    status.set_start(station)
  end

  def fare(finish = nil)
    penalty?(finish) ? penalty_fare : standard_fare
  end

  def complete_journey(finish)
    commit_journey(start, finish) if should_commit_with? finish
    fare(finish)
  end

  private

  def should_commit_with?(station)
    in_journey? || penalty?(station)
  end

  def commit_journey(start, finish)
    @journeys << Journey.new(start, finish)
  end

  def start
    @status.start
  end

  def in_journey?
    !status.clear?
  end

  def penalty_fare
    6
  end

  def standard_fare
    in_journey? ? 1 : 0
  end

  def penalty?(station)
    !!in_journey? ^ !!station
  end

end
