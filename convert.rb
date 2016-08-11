module Convert
  def convert_coordinates(string)
    @letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
    column = string.match(/\d+/)[0].to_i
    [column-1, @letters.index(string[0])]
  end

  def reverse(convert)
    column = @letters[convert[1]]
    row = convert[0]+1
    column + row.to_s
  end
end
