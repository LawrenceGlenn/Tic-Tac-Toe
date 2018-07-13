require_relative 'player'
require_relative 'board'

class AI < Player

  def move(board, rules)

    #determine the best move for the AI to make
    ai_move(board, rules)

    #make AI's move
    rules.make_move(@best_choice, board)
  end

  def ai_move(board, rules)

    #if the current board says the game is over return as score based on if AI won or lost
    return score(board, rules) if rules.game_over?(board)
    scores = {}

    #determine every possible move and loop through them
    board.get_empty_spaces.each do |move|

      #create a temporary board and temporary rules to make our theoretical moves in
      #must use Marshal.load( Marshal.dump(board)) to create a deep copy of the board state
      #without it the temp_board still references the array in the original board
      temp_board = Marshal.load( Marshal.dump(board) )
      temp_rules = Marshal.load( Marshal.dump(rules) )

      #make a theoretical move of the first possible empty space
      temp_rules.make_move(move, temp_board)

      #switch who the theoretical current player
      temp_rules.switch_players
      
      #recursivly pass current temporary board and rules
      #final results should be returned and stored in scores
      scores[move] = ai_move(temp_board, temp_rules)

    end
    #determined best choice and score
    @best_choice, best_score = best_move(rules.current_player.marker, scores)

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

  def score(board, rules)

    #return a value of +10, -10, or 0 based on if end game
    #was victory for AI, loss, or Draw
    if rules.winner?(board) && rules.who_won(board).to_s.eql?(@marker.to_s) then
      return 10
    elsif rules.winner?(board)
      return -10
    end
    0
  end

  private :ai_move, :best_move, :score

end