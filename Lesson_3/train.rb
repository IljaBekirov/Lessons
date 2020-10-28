class Train
  attr_accessor :wagons, :speed, :route, :station
  attr_reader :number, :type

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
    @route = nil
    @station = 'depo'
  end

  def speed_up(step)
    @speed += step.to_f
  end

  def speed_down(step)
    @speed -= step.to_f
  end

  def speed_stop
    @speed = 0
  end

  def add_wagons(count)
    if speed.zero?
      @wagons += count.to_i
      puts "В состав добавили #{count} вагонов, итого #{@wagons} вагонов"
    else
      puts "Поезд движется со скоростью #{speed}. Прицеплять вагоны разрешено только к стоящему поезду"
    end
  end

  def del_wagons(count)
    if speed.zero?
      @wagons -= count.to_i
      puts "Из состава убрали #{count} вагонов, итого #{@wagons} вагонов"
    else
      puts "Поезд движется со скоростью #{speed}. Отцеплять вагоны разрешено только от стоящего поезда"
    end
  end

  def add_routes(route)
    @index_station = 0
    @route = route
    @station = @route.stations[@index_station]
    @station.train_arrival(self)
  end

  def go_forvard
    @station.train_departure(self)
    @station = @route.stations[@index_station += 1]
    @station.train_arrival(self)
  end

  def go_back
    @station.train_departure(self)
    @station = @route.stations[@index_station -= 1]
    @station.train_arrival(self)
  end

  def previous_station
    index = @index_station - 1
    if index.negative?
      puts 'Это первая станция в маршруте, предыдущей станции нет'
    else
      @route.stations[index]
    end
  end

  def next_station
    index = @index_station + 1
    if @route.stations.size - 1 < index
      puts 'Это конечная станция в маршруте'
    else
      @route.stations[index]
    end
  end
end