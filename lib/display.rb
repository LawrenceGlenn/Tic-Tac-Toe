class Display

  Green = 32
  Red = 31
  Blue = 34

  def startup_screen
    puts "\nYou are about to play"
    puts  red_text("TIC") + "-" + green_text("TAC") + "-" + blue_text("TOE") + "\n\n"
  end

  def announce_players_turn(player)
    puts "\nIt is player #{player.marker}'s turn\n"
  end

  def render_board(board)
      #line break
      puts "\nCURRENT BOARD"
      # loop through the board
      board.board.each_with_index do |row, index|
          row.each_with_index do |cell, index|
            #dispaly column seperations
            print("|") if index>0
            # display markers
            cell.nil? ? print("   ") : print(" "+cell.to_s+" ")
          end
          #display row seperations
          puts "\n-----------" if index<2
      end
      #line break
      puts "\n\n"
  end

  def game_over_message(board)
     if board.draw?
      puts "Game ended in a "+red_text("draw...")
    elsif board.winner?
      puts "Player #{board.who_won}"+green_text("WINS!!!")
    else
      puts "Game is not over yet ..."
    end
  end
  
  def ask_is_player_a_computer?(marker)
    #ask user if player is a computer
    puts "Is player (#{marker}) a computer player? (y/n)"
    gets.strip.to_s
  end

  def y_n_format_error
    puts "You must answer with a y or n"
  end

  def ask_for_move
      # Ask users for move
      puts "Make your move with numbers 0 to 2 in the form of row,column:"
      gets.strip.split(",").map(&:to_i)
  end

  def out_of_bounds_warning
    puts "Marker coordinates are out of bounds"
  end

  def space_full_warning
    puts "There is already a marker there!"
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

end