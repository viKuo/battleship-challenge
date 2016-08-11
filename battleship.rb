require_relative 'board'
require_relative 'convert'

class Battleship
  include Convert

  def initialize
    @user_board = Board.new
    @computer_board = Board.new
    @computer_board.random_placement
  end

  def start_game
    puts "Hello and welcome to Battleship! We will start by placing ships. Type random to randomize placement."
    @user_board.print(false)
    place_user_ships
    start_shooting
  end

  private
  def place_user_ships
    ship_types = ["carrier", "battleship", "cruiser", "destroyer 1", "destroyer 2", "submarine 1", "submarine 2"]
    ship_types.each do |ship|
      placeable = false
      begin
        begin
          puts "Where would you like to place your #{ship}?"
          location = gets.chomp
          if location == "random"
            @user_board.random_placement
            puts "This is your board:"
            @user_board.print(false)
            return
          end
        end until location.index(/^[A-J]\d+$/)

        begin
          puts "Would you like your #{ship} to be horizontal or vertical?"
          orientation = gets.chomp
        end until orientation == "horizontal" || orientation == "vertical"
        placeable = @user_board.insert_ship(Ship.new(ship, convert_coordinates(location), orientation))
        if placeable == false then puts "Not a valid position. Please choose again" end
      end until placeable
      puts "Your ship has been placed."
      @user_board.print(false)
    end
  end

  def start_shooting
    while @user_board.live_ships > 0 && @computer_board.live_ships > 0
      @user_board.live_ships.times { user_shot }
      @computer_board.live_ships.times{ computer_shot }
    end
  end

  def user_shot
    puts "Call out your shot or type history"
    shot = gets.chomp

    case shot
    when "view" #cheating!
      @computer_board.print(false)
      user_shot
      return
    when "history"
      @computer_board.print(true)
      user_shot
      return
    when /^[A-J]\d0?/
      shot = convert_coordinates(shot)
      @computer_board.shot(shot[0], shot[1])
    else
      puts "Invalid coordinates. Please try again."
      user_shot
    end
  end

  def computer_shot
    begin
      sleep(1)
      location = [rand(9), rand(9)]
      puts "Opponent shot at #{reverse(location)}"
      result = @user_board.shot(rand(9), rand(9))
      @user_board.print(false)
    end until result
  end
end



game = Battleship.new

game.start_game
