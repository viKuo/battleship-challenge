require_relative '../convert'

describe Convert do
  include Convert
  it 'converts A1 to 0, 0' do
    expect(convert_coordinates("A1")).to eq [0,0]
  end

  it 'converts B3 to 2, 1' do
    expect(convert_coordinates("B3")).to eq [2,1]
  end

  it 'converts E4 to 3, 4' do
    expect(convert_coordinates("E4")).to eq [3,4]
  end

  it 'converts J10 to 9,9' do
    expect(convert_coordinates("J10")).to eq [9,9]
  end
end
