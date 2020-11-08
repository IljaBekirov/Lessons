# frozen_string_literal: true

class PassengerWagon < Wagon
  attr_accessor :free_seats
  attr_reader :number, :seats

  def initialize(number, seats)
    super()
    @number = number
    @seats = seats
    @free_seats = seats
  end

  def take_seat
    @free_seats -= 1
  end

  def occupied_seat
    @seats - @free_seats
  end
end
