class Status
  
  attr_reader :start, :finish

  def initialize(start: nil, finish: nil)
    @start = start
  end

  def set_start(start)
    @start = start
  end

  def clear
    @start = nil
  end

  def clear?
    @start.nil?
  end
end
