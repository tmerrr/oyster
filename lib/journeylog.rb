require_relative 'journey.rb'

class JourneyLog

  attr_reader :journey_class

  def initialize(journey_class: Journey)
    @journey_class = journey_class
  end

  def start_new_journey
    @journey = @journey_class.new
  end

end
