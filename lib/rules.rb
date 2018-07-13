class Rules
  attr_accessor :current_player

  def initialize(firstPlayer, secondPlayer)
    @playerX = firstPlayer
    @playerO = secondPlayer
  end

  def winner?(board)
    #check if there was a winner
    board.any_diagonal_markers_same? || board.any_row_or_column_markers_same?
  end

  def who_won(board)

    #return marker from a winning combination
    return board.board[4] if board.any_diagonal_markers_same?
    (0..2).each do |i|
      return board.board[i*3] if board.row_markers_same?(i)
      return board.board[i] if board.column_markers_same?(i)
    end
    nil
  end


  def draw?(board)
    board.is_board_full?
  end


  def is_move_valid?(board, coords)
      valid_coordinate_character?(coords) && board.coordinates_available?(coords)
  end


  def valid_coordinate_character?(coords)
    #set is_int to false if coords are not an integer
    is_int = Integer(coords) rescue false
    # check if marker coordinatess are in the possible range and are an integer if not display error
    if is_int && (0..8).include?(is_int) then
      true 
    else
      false
    end
  end

  def game_over?(board)
    winner?(board) || draw?(board)
  end

  def switch_players
    #switch current player
    @current_player.marker == @playerX.marker ? @current_player = @playerO : @current_player = @playerX 
  end

  def make_move(move, board)
    #tell the board to place a marker
    board.place_piece(move, @current_player.marker)

  end

  def take_turn(board)
    #has a player take their turn and switch to the next player
    current_player.move(board, self)
    switch_players
  end

end