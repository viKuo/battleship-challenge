require_relative 'board'
require_relative 'convert'

class Battleship
  include Convert

  def initialize
    @board = Board.new
  end

  def start_game
    puts "Hello and welcome to Battleship! We will start by placing ships."
    @board.print
    ship_types = ["carrier", "battleship", "cruiser", "destroyer", "destroyer", "submarine", "submarine"]
    ship_types.each do |ship|
      placeable = false
      begin
        begin
          puts "Where would you like to place your #{ship}?"
          location = gets.chomp
        end until location.index(/^[A-J]\d+$/)
        
        begin 
          puts "Would you like your #{ship} to be horizontal or vertical?"
          orientation = gets.chomp
        end until orientation == "horizontal" || orientation == "vertical"
        placeable = @board.insert_ship(Ship.new(ship, convert_coordinates(location), orientation))
      end until placeable

      p "Your ship has been placed."
      @board.print
    end
  end

end

game = Battleship.new

game.start_game


# test placeable here and in board private placeable
# or if ship placement is off the board