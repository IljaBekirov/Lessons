class CargoTrain < Train
  attr_accessor :type

  def initialize(number)
    super
    @type = 'Cargo'
  end
end
