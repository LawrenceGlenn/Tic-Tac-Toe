require_relative 'lib/board'
require_relative 'lib/player'
require_relative 'lib/display'
require_relative 'lib/human'
require_relative 'lib/ai'


class TicTacToe

  def initialize

    #create display for players
    @display = Display.new

    #create the board
    @board = Board.new(@display)

    @display.startup_screen

    #create players
    @player_X = set_player_to_human_or_computer(:x)
    @player_O = set_player_to_human_or_computer(:o)

    # set player x as the starting player
    @current_player = @player_X
    @current_opponent = @player_O
  end

  def play

    #display the starting board
    @display.render_board(@board)

    #loop to play the game
    while true
      #current player makes a move
      @display.announce_players_turn(@current_player)
      @current_player.move(@board)

      #display the board
      @display.render_board(@board)

      #check if game is over, if not then switch players and start a new turn
      @board.game_over?? break : next_player
    end

    @display.game_over_message(@board)

  end

  def next_player
    @current_player, @current_opponent = @current_opponent, @current_player
  end

  def set_player_to_human_or_computer(marker)

    #keep asking user if a player is a computer until they give a valid response
    while true
      response = @display.ask_is_player_a_computer?(marker)

      #if the response is valid stop asking, if not ask user to try again
      valid_y_n_response?(response)? break : @display.y_n_format_error
    end
     #return the correct kind of player based on user input
    response == 'y'? AI.new(marker, @display) : Human.new(marker, @display)
  end

  def valid_y_n_response?(response)
    ['y','n'].include?(response)
  end

end

# starts the game when you run the file
t = TicTacToe.new
t.play