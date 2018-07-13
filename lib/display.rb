require_relative 'inputoutput.rb'

class Display

  Green = 32
  Red = 31
  Blue = 34

  Example_Board = [0,1,2,3,4,5,6,7,8]

  def initialize
    @inOut = Inputoutput.new
  end

  def startup_screen
    #display intro insctructions and welcome
    @inOut.display_text("\nYou are about to play")
    @inOut.display_text(red_text("TIC") + "-" + green_text("TAC") + "-" + blue_text("TOE") + "\n\n")
    @inOut.display_text("How to play: Select your move with numbers 0 through 8 \nas displayed on the example board below\n\n")
    @inOut.display_text(create_text_for_board(Example_Board)+ "\n\n")
  end

  def announce_players_turn(player)
    @inOut.display_text("\nIt is player #{player.marker}'s turn\n")
  end

  def render_board(board)
    #line break
    @inOut.display_text("\nCURRENT BOARD")
    @inOut.display_text(create_text_for_board(board.board))
    #line break
    @inOut.display_text("\n\n")
  end

  def create_text_for_board(board)
    #create variable for displaying content
    board_string = ""
    # loop through the board
    board.each_with_index do |cell, index|
      #dispaly column seperations
      board_string = board_string.concat("|") if ((index-1)%3) == 0 or ((index-2)%3) == 0
      # display markers
      cell.nil? ? board_string.concat("   ") : board_string.concat(" "+cell.to_s+" ")
      #display row seperations
      board_string = board_string + "\n-----------\n" if index == 2 || index == 5
    end
    board_string
  end

  def game_over_message(rules, board)
    #output a win or draw message
    if rules.winner?(board)
      @inOut.display_text("Player #{rules.who_won(board)}"+green_text(" WINS!!!"))
    elsif rules.draw?(board)
      @inOut.display_text("Game ended in a "+red_text("draw..."))
    else
      @inOut.display_text("Game is not over yet ...")
    end
  end
  
  def ask_is_player_a_computer?(marker)
    #ask user if player is a computer
    @inOut.display_text("Is player (#{marker}) a computer player? (y/n)")
    @inOut.get_input_text.strip.to_s
  end

  def y_n_format_error
    @inOut.display_text("You must answer with a y or n")
  end

  def ask_for_move
      # Ask users for move
      @inOut.display_text("Make your move with numbers 0 to 8:")
      @inOut.get_input_text
  end

  def invalid_move_error
    @inOut.display_text("Your selection must be an empty space between 0 and 8")
  end

  def console_text_effect(text, code)
    #create a console effect
    "\e[#{code}m#{text}\e[0m"
  end

  def red_text(text)
    console_text_effect(text, Red)
  end
  def green_text(text)
    console_text_effect(text, Green)
  end
  def blue_text(text)
    console_text_effect(text, Blue)
  end

  private :console_text_effect, :red_text, :green_text, :blue_text

end