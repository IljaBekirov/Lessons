class PassengerTrain < Train
  attr_accessor :type

  def initialize(number)
    super
    @type = 'Passenger'
  end

  def add_wagons(wagon)
    unless wagon.class.to_s == 'PassengerWagon'
      puts 'К пассажирскому поезду можно прицеплять только пассажирский вагон!'
      return
    end
    if speed.zero?
      @wagons << wagon
      puts "В состав добавили пассажирский вагон, итого #{@wagons.count} вагонов"
    else
      puts "Поезд движется со скоростью #{speed}. Прицеплять вагоны разрешено только к стоящему поезду"
    end
  end

  def del_wagons
    if speed.zero?
      if @wagons.count.zero?
        puts 'В составе нет ни одного вагона'
        return
      end
      @wagons.delete_at(-1)
      puts "Из состава убрали вагон, итого #{@wagons.count} вагонов"
    else
      puts "Поезд движется со скоростью #{speed}. Отцеплять вагоны разрешено только от стоящего поезда"
    end
  end
end
