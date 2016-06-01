require_relative '../board'

describe Board do
  let(:board) { Board.new }
  let(:ships) { 
    carrier = Ship.new("carrier", [0,0], "horizontal")
    battleship = Ship.new("battleship", [1,1], "horizontal")
    cruiser = Ship.new("cruiser", [6,2], "horizontal")
    destroyer = Ship.new("destroyer", [7, 4], "horizontal")
    submarine = Ship.new("submarine", [9,9], "horizontal") 
    [carrier, battleship, cruiser, destroyer, submarine] }

  it 'generates a 10 by 10 array' do
    expect(board.board.size).to eq 10
  end

  it 'generates a 10 by 10 array' do
    expect(board.board[0].size).to eq 10
  end

  it 'can fire shots given coordinates' do
    expect { board.shot(0, 1) }.to change { board.board[0][1] }
  end

  it 'starts with 5 live ships' do
    ships.each { |ship| board.insert_ship(ship) }
    expect(board.live_ships).to eq 5
  end

  it 'can shoot down a ship' do
    submarine = Ship.new("submarine", [9,9], "horizontal")
    board.insert_ship(submarine)
    expect { board.shot(9, 9) }.to change { board.live_ships }
  end

  it 'cannot overlap ships' do
    submarine = Ship.new("submarine", [9,9], "horizontal")
    board.insert_ship(submarine)
    expect { board.insert_ship(submarine) }.to_not change { board.board[9][9] }
  end
end

