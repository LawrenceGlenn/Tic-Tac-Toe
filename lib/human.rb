require_relative 'player'

class Human < Player
  def move(board, rules)

    while true
      #get move from user
      move = @display.ask_for_move.strip
      if rules.is_move_valid?(board, move) then 
        #if move was valid make the move and stop asking for a move
        rules.make_move(move, board)
        break
      else
        #if move was nto valid display error message
        @display.invalid_move_error
      end
    end
  end

end