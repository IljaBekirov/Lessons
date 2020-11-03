require './company_name'
require './instance_counter'

class Train
  include CompanyName
  include InstanceCounter
  # extend InstanceCounter::ClassMethods

  @@trains = {}

  def self.find(train_number)
    @@trains[train_number]
  end

  attr_accessor :speed, :route, :station, :wagons
  attr_reader :number

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    @@trains.merge!(number.to_s => self)
    # register_instance
  end

  def add_routes(route)
    @index_station = 0
    @route = route
    @station = @route.stations[@index_station]
    @station.train_arrival(self)
  end

  def go_forvard
    return if next_station.nil?

    @station.train_departure(self)
    @station = @route.stations[@index_station += 1]
    @station.train_arrival(self)
  end

  def go_back
    return if previous_station.nil?

    @station.train_departure(self)
    @station = @route.stations[@index_station -= 1]
    @station.train_arrival(self)
  end

  private

  def previous_station
    if (@index_station - 1).negative?
      puts 'Это первая станция в маршруте, предыдущей станции нет'
    else
      true
    end
  end

  def next_station
    if @route.stations.size - 1 < @index_station + 1
      puts 'Это конечная станция в маршруте'
    else
      true
    end
  end
end
