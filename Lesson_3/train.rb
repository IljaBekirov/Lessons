require './company_name'
require './instance_counter'

class Train
  include CompanyName
  include InstanceCounter
  # extend InstanceCounter::ClassMethods

  TRAIN_NUMBER = /\w{3}-\w{2}|\w{5}/i.freeze

  @@trains = {}

  def self.find(train_number)
    @@trains[train_number]
  end

  def self.all
    @@trains
  end

  attr_accessor :speed, :route, :station, :wagons
  attr_reader :number

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    @@trains.merge!(number.to_s => self)
    validate!
    # register_instance
  end

  def add_wagons(wagon)
    unless wagon.class.to_s.include?(type)
      raise 'Данному типу поезда не подходит этот тип вагона'
    end

    unless speed.zero?
      raise "Поезд движется со скоростью #{speed}. Прицеплять вагоны разрешено только к стоящему поезду"
    end

    @wagons << wagon
    puts "В состав добавили вагон, итого #{@wagons.count} вагон(ов)"
  end

  def del_wagons
    unless speed.zero?
      raise "Поезд движется со скоростью #{speed}. Отцеплять вагон разрешено только от стоящего поезда"
    end

    raise 'В составе нет ни одного вагона' if @wagons.count.zero?

    @wagons.delete_at(-1)
    puts "Из состава убрали вагон, итого #{@wagons.count} вагонов"
  end

  def add_routes(route)
    @index_station = 0
    @route = route
    @station = @route.stations[@index_station]
    @station.train_arrival(self)
  end

  def go_forvard
    return next_station unless next_station

    @station.train_departure(self)
    @station = @route.stations[@index_station += 1]
    @station.train_arrival(self)
  end

  def go_back
    return previous_station unless previous_station

    @station.train_departure(self)
    @station = @route.stations[@index_station -= 1]
    @station.train_arrival(self)
  end

  private

  def previous_station
    if (@index_station - 1).negative?
      raise 'Это первая станция в маршруте, предыдущей станции нет'
    end

    true
  end

  def next_station
    if @route.stations.size - 1 < @index_station + 1
      raise 'Это конечная станция в маршруте'
    end

    true
  end

  def validate?
    validate!
    true
  rescue
    false
  end

  def validate!
    raise 'Номер поезда не соответствует формату' if number !~ TRAIN_NUMBER
  end
end
