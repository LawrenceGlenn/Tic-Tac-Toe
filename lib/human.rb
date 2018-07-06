require_relative 'player'

class Human < Player
  def move(board)

    while true
      #get move from user
      move = @display.ask_for_move
      if board.is_move_valid?(move) then 
        #if move was valid make the move and stop asking for a move
        board.make_move(move, @marker)
        break
      end
    end
  end

end