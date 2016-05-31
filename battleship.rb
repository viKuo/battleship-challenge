require_relative 'board'
require_relative 'convert'
class Battleship
  include Convert
  def initialize
    @board = Board.new
    carrier = Ship.new("carrier", convert_coordinates("A1"), "horizontal")
    battleship = Ship.new("battleship", convert_coordinates("B2"), "horizontal")
    cruiser = Ship.new("cruiser", convert_coordinates("C7"), "horizontal")
    destroyer = Ship.new("destroyer", convert_coordinates("E8"), "horizontal")
    submarine = Ship.new("submarine", convert_coordinates("J10"), "horizontal")
    @board.insert_ship(carrier)
    @board.insert_ship(carrier)
    @board.print
  end
end
Battleship.new
