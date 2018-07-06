require_relative 'display'

class Board
  attr_reader :board

  def initialize(disp)
    # create a 3 by 3 board
    @board = Array.new(3){Array.new(3)}
    @display = disp
  end

  def winner?
    any_diagonal_markers_same? || any_row_or_column_markers_same?
  end

  def who_won

    #return marker from a winning combination
    return @board[1][1] if any_diagonal_markers_same?
    (0..2).each do |i|
      return @board[i][1] if row_markers_same?(i)
      return @board[1][i] if column_markers_same?(i)
    end
    nil
  end

  def any_diagonal_markers_same?

    #check if there is a winning diagonal
    if @board[0][0]==@board[1][1] && @board[1][1]==@board[2][2] && !@board[1][1].nil? then
      return true
    elsif @board[2][0]==@board[1][1] && @board[1][1]==@board[0][2] && !@board[1][1].nil? 
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
    return true if @board[i][0]==@board[i][1] && @board[i][1]==@board[i][2] && !@board[i][1].nil?
    false
  end

  def column_markers_same?(i)

    #does this column contain the same markers?
      return true if @board[0][i]==@board[1][i] && @board[1][i]==@board[2][i] && !@board[1][i].nil?
    false
  end

  def draw?
    # check if the board is full
    @board.all? do |row|
      row.none?(&:nil?)
    end
  end


  def make_move(coords, marker)
    
      # place marker
      @board[coords[0]][coords[1]] = marker
  end


  def is_move_valid?(coords)
      within_valid_coordinates_range?(coords) && coordinates_available?(coords)
  end


  def within_valid_coordinates_range?(coords)

      # check if marker coordinatess are in the possible range and if not display error
      if ((0..2).include?(coords[0]) && (0..2).include?(coords[1])) then
        true 
      else
        @display.out_of_bounds_warning
        false
      end
  end


  def coordinates_available?(coords)
      # check if there is already a marker in this position and if so display error
      @board[coords[0]][coords[1]].nil? ? true : @display.space_full_warning
  end

  def game_over?
    winner? || draw?
  end

  def get_empty_spaces

    #find any empty spaces
    available = []
    @board.each_index do |i|
      @board.each_index do |j|
        available << [i,j] if @board[i][j].nil? 
      end
    end
    available
  end

end