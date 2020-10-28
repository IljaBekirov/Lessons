class Station
  attr_accessor :trains
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def all_trains(type = nil)
    return trains if type.nil?

    trains.select { |train| train if train.type == type }
  end

  def train_arrival(train)
    trains << train
  end

  def train_departure(train)
    trains.delete(train)
  end
end
