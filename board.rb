require_relative 'ship'
require_relative 'convert'

class Board
  attr_reader :board
  include Convert

  def initialize
    @board = Array.new(10) { Array.new(10, "-") }
    @ships = []
  end

  def shot(row, column)
    case @board[row][column]
    when "-"
      @board[row][column] = "/"
    when "O"
      @board[row][column] = "X"
    when "/" || "X"
      puts "Repeated coordinate"
    end
    check_if_ship_sank
  end

  def insert_ship(ship)
    if placeable?(ship)
      @ships << ship
      if ship.orientation == "horizontal"
        ship.size.times do |time|
          @board[ship.location[0]][ship.location[1]+time] = "O"
        end
      elsif ship.orientation == "vertical"
        ship.size.times do |time|
          @board[ship.location[0]+time][ship.location[1]] = "O"
        end
      end
      true
    else
      false
    end
  end

  def live_ships
    count = @ships.size
    @ships.each { |ship| if ship.dead? then count -= 1 end }
    count
  end

  def print
    puts "   A B C D E F G H I J "
    puts "  _____________________"
    counter = 1
    @board.each do |line|
      if counter < 10
        print = counter.to_s + " "
      else
        print = counter.to_s
      end
      line.each do |element|
        print << "|"
        if element == "-"
          print << "-"
        else
          print << element
        end
      end
      print << "|"
      puts print
      counter += 1
    end
    puts "  ---------------------"
  end

  private
  def placeable?(ship)
    if (0..9).include?(ship.location[0]) || (0..9).include?(ship.location[1]) then return false end
    fields = ship_fields(ship)
    return false if fields.include?("O") || fields.include?(nil)
    true
  end

  def check_if_ship_sank
    @ships.each do |ship|
      field = ship_fields(ship)
      if !field.include?("-")
        puts "#{ship} has sunk."
        ship.die
      end
    end
  end

  def ship_fields(ship)
    if ship.orientation == "horizontal"
      ship_range = (ship.location[1]...ship.location[1]+ship.size)
      @board[ship.location[0]][ship_range]
    elsif ship.orientation == "vertical"
      ship_range = (ship.location[0]...ship.location[0]+ship.size)
      field = []
      ship_range.each do |time|
        field << @board[time][ship.location[1]]
      end
      field
    end
  end
end

# board = Board.new
# board.print
