require_relative 'convert'

class Ship
  include Convert
  attr_reader :type, :location, :orientation

  def initialize(type, location, orientation)
    @type = type
    @location = location
    @orientation = orientation
    @dead = false
  end

  def dead?
    @dead
  end

  def die
    @dead = true
  end

  def size
    case @type
    when "carrier"
      5
    when "battleship"
      4
    when "cruiser"
      3
    when "destroyer"
      2
    when "submarine"
      1
    end
  end
end
