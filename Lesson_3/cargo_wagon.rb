# frozen_string_literal: true

class CargoWagon < Wagon
  attr_accessor :free_volume
  attr_reader :volume

  def initialize(volume)
    super()
    @volume = volume
    @free_volume = volume
  end

  def up_volume(volume)
    @free_volume -= volume
  end

  def occupied_volume
    @volume - @free_volume
  end
end
