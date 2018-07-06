require_relative 'player'
require_relative 'board'

class AI < Player

  def move(board)

    #determine the best move for the AI to make
    ai_move(board, marker)

    #make AI's move
    board.make_move(@best_choice, marker)
  end

  def ai_move(board, current_player)

    #if the current board says the game is over return as score based on if AI won or lost
    return score(board, current_player) if board.game_over?
    scores = {}

    #determine every possible move and loop through them
    board.get_empty_spaces.each do |move|

      #create a temporary board to make our theoretical moves in
      #must use Marshal.load( Marshal.dump(board)) to create a deep copy of the board state
      #without it the temp_board still references the array in the original board
      temp_board = Marshal.load( Marshal.dump(board) )

      #make a theoretical move of the first possible empty space
      temp_board.make_move(move, current_player)

      #recursivly pass current temporary board and set the other player to make their move
      #final results should be returned and stored in scores
      scores[move] = ai_move(temp_board, switch_markers(current_player))

    end
    #determined best choice and score
    @best_choice, best_score = best_move(current_player, scores)

    # return the best score found
    best_score

  end

  def best_move(marker, scores)
    if marker == @marker

      #if the current marker is the AI's return the highest move and score
      #based on the score
      scores.max_by {|move, score| score}
    else

      #if the current marker is the AI opponent's return the lowest move and score
      #based on the score
      scores.min_by {|move, score| score}
    end
  end

  def score(board, current_player)

    #return a value of +10, -10, or 0 based on if end game
    #was victory for AI, loss, or Draw
    if board.winner? && board.who_won.to_s.eql?(@marker.to_s) then
      return 10
    elsif board.winner?
      return -10
    end
    0
  end







  def switch_markers(marker)
    #reverse possible player markers
    marker == :x ? :o : :x
  end
end