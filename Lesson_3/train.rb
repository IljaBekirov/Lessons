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
    raise 'Данному типу поезда не подходит этот тип вагона' unless wagon.class.to_s.include?(type)

    if speed.zero?
      @wagons << wagon
      puts "В состав добавили вагон, итого #{@wagons.count} вагон(ов)"
    else
      raise "Поезд движется со скоростью #{speed}. Прицеплять вагоны разрешено только к стоящему поезду"
    end
  end

  def del_wagons
    raise "Поезд движется со скоростью #{speed}. Отцеплять вагон разрешено только от стоящего поезда" unless speed.zero?

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
    return next_station if next_station.nil?

    @station.train_departure(self)
    @station = @route.stations[@index_station += 1]
    @station.train_arrival(self)
  end

  def go_back
    return previous_station if previous_station.nil?

    @station.train_departure(self)
    @station = @route.stations[@index_station -= 1]
    @station.train_arrival(self)
  end

  private

  def previous_station
    if (@index_station - 1).negative?
      raise 'Это первая станция в маршруте, предыдущей станции нет'
    else
      true
    end
  end

  def next_station
    if @route.stations.size - 1 < @index_station + 1
      raise 'Это конечная станция в маршруте'
    else
      true
    end
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
