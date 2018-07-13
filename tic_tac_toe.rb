require_relative 'lib/board'
require_relative 'lib/player'
require_relative 'lib/display'
require_relative 'lib/human'
require_relative 'lib/ai'
require_relative 'lib/rules'


class TicTacToe

  def initialize

    #create display for players
    @display = Display.new

    #create the board
    @board = Board.new

    @display.startup_screen

    #create players
    @player_X = set_player_to_human_or_computer(:x)
    @player_O = set_player_to_human_or_computer(:o)

    #initialize the rules
    @rules = Rules.new(@player_X, @player_O)
  end

  def play

    #set first player
    @rules.current_player = @player_X

    #display the starting board
    @display.render_board(@board)

    #loop to play the game until game over is true
    until @rules.game_over?(@board) do
      #current player makes a move
      @display.announce_players_turn(@rules.current_player)


      @rules.take_turn(@board)

      #display the board
      @display.render_board(@board)
    end

    @display.game_over_message(@rules, @board)

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

  private :set_player_to_human_or_computer

end

# starts the game when you run the file
t = TicTacToe.new
t.play