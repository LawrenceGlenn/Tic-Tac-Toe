require_relative 'display'

class Board
  attr_reader :board

  def initialize
    # create a 9 space board
    @board = Array.new(9)
  end

  def any_diagonal_markers_same?

    #check if there is a winning diagonal
    if @board[0]==@board[4] && @board[4]==@board[8] && !@board[4].nil? then
      return true
    elsif @board[2]==@board[4] && @board[4]==@board[6] && !@board[4].nil? then
      return true
    else
      false
    end
  end

  def any_row_or_column_markers_same?
    #check if there is a winning row or column
    (0..2).each { |i| return true if row_markers_same?(i) or column_markers_same?(i) }
    false
  end

  def row_markers_same?(i)

    #does this row contain the same markers?
    return true if @board[i*3]==@board[(i*3)+1] && @board[(i*3)+1]==@board[(i*3)+2] && !@board[i*3].nil?
    false
  end

  def column_markers_same?(i)

    #does this column contain the same markers?
      return true if @board[i]==@board[i+3] && @board[i+3]==@board[i+6] && !@board[i].nil?
    false
  end


  def place_piece(coords, marker)
      # place marker
      @board[coords.to_i] = marker
  end


  def coordinates_available?(coords)
      # check if there is already a marker in this position
      @board[coords.to_i].nil? ? true : false
  end

  def is_board_full?
    # check if the board is full
    @board.none?(&:nil?)
  end

  def get_empty_spaces

    #find any empty spaces
    available = []
    @board.each_index do |i|
      available << i if @board[i].nil?
    end
    available
  end

end