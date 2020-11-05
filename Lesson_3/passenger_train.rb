# frozen_string_literal: true

class PassengerTrain < Train
  attr_accessor :type

  def initialize(number)
    super
    @type = 'Passenger'
  end
end
