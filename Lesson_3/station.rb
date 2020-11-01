class Station
  attr_accessor :trains
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  private

  # Эти методы в привате, т.к. они не вызываются напрямую из главного приложения, а только через связующий метод

  def train_arrival(train)
    trains << train
  end

  def train_departure(train)
    trains.delete(train)
  end
end
