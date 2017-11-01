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

  def complete_journey(station)
    commit_journey(station) if should_commit_with? station
    fare(station)
  end

  private

  def should_commit_with?
    in_journey? || penalty?(station)

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
