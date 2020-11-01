class CargoTrain < Train
  attr_accessor :type

  def initialize(number)
    super
    @type = 'Cargo'
  end

  def add_wagons(wagon)
    unless wagon.class.to_s == 'CargoWagon'
      puts 'К грузовому поезду можно прицеплять только грузовой вагон!'
      return
    end
    if speed.zero?
      @wagons << wagon
      puts "В состав добавили грузовой вагон, итого #{@wagons.count} вагон(ов)"
    else
      puts "Поезд движется со скоростью #{speed}. Прицеплять вагоны разрешено только к стоящему поезду"
    end
  end

  def del_wagons
    if speed.zero?
      @wagons.delete_at(-1)
      puts "Из состава отцепили грузовой вагон, итого #{@wagons.count} вагон(ов)"
    else
      puts "Поезд движется со скоростью #{speed}. Отцеплять вагоны разрешено только от стоящего поезда"
    end
  end
end
