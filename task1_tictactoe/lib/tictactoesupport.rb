class TictactoeSupport

  attr_accessor :round_number

  def init_new_game                                                            # setup, introduction etc.
    puts "\nGRA W KÓŁKO I KRZYŻYK"                                             # introduce the game

    @board = Array.new(3) { Array.new(3) }                                     # 2-dimensional array to fill with "x" and "o"
    @addresses = ["A1", "A2", "A3", "B1", "B2", "B3", "C1", "C2", "C3"]        # dictionary of proper cell addresses from user input
    @input_history = []                                                        # a table to collect user inputs to check if the same cell isn't inputted twice

    draw_gameboard
    introduce_players

    @round_number = 1                                                          # every new round will increment this number by 1 and the odd rounds are for prayer1 and the even for player2
    true
  end

  def winner?                                                                  # winner existence flag
    if @winner != nil
      true
    else
      false
    end
  end

  def end_game_when_there_is_winner                                            # awards winner and ends game
    puts "\n\nZwycięzcą jest #{@winner}. Gratulacje! \n\nKoniec gry."
  end

  def all_cells_filled?                                                        # all cells in gameboard filled flag
    if (@board.all? { |cell| cell.all? { |e| e != nil } } )
      true
    else
      false
    end
  end

  def end_game_if_all_cells_filled                                             # ends game when all cells are filled and there istn't winner
    puts "\n\nWszystkie pola w tablicy wypełnione. Nikt nie wygrał. \n\nKoniec gry."
    true
  end

  def init_round                                                               # introduces new round
    puts "\n\nRunda #{@round_number}:\n"
    true
  end

  def ask_user_to_choose_cell                                                  # asks user to input cell address and gets this cell
    print "\n@#{@player1}, podaj pole, w którym postawić kółko (np. B1 - kolumna 2 wiersz 3): " if @round_number.odd?
    print "@#{@player2}, podaj pole, w którym postawić krzyżyk (np. B1 - kolumna 2 wiersz 3): " if @round_number.even?
    @given_cell = STDIN.gets.chomp
    true
  end

  def given_cell_available?                                                    # checks if the given inputted cell exists in gameboard and is empty (available to fill in)
    if ( @addresses.find {|address| address == @given_cell.upcase } == nil ) || ( @input_history.index(@given_cell.upcase) != nil )
      false
    else
      true
    end
  end

  def put_message_about_cell_unavailability_to_user                            # inform that the user can't fill in inputted cell because isn't empty or doesn't exist
    puts "\nPola #{@given_cell.upcase} nie ma lub jest wypełnione. Wybierz inne pole."
    true
  end

  def actualize_input_history                                                  # adds filled in cell into input history not to overwrite this cell in the next rounds
    @input_history << @given_cell.upcase
    true
  end

  def put_sign_on_gameboard(sign)                                              # fills in inputted cell with user's sign
    translate_given_cell_to_board_address                                      # translate human addresses A1, C3 etc to board (array) indexes
    fill_in_gameboard(@address_row, @address_column, sign)
    true
  end

  def check_winner
    [0,1,2].each do |row_or_column|
      if (@board[row_or_column][0] == @board[row_or_column][1] && @board[row_or_column][1] == @board[row_or_column][2] && @board[row_or_column][0] == "o") ||
         (@board[0][row_or_column] == @board[1][row_or_column] && @board[1][row_or_column] == @board[2][row_or_column] && @board[0][row_or_column] == "o") ||
         (@board[0][0] == @board[1][1] && @board[1][1] == @board[2][2] && @board[0][0] == "o") ||
         (@board[0][2] == @board[1][1] && @board[1][1] == @board[2][0] && @board[0][2] == "o")
        @winner = @player1
        break
      elsif (@board[row_or_column][0] == @board[row_or_column][1] && @board[row_or_column][1] == @board[row_or_column][2] && @board[row_or_column][0] == "x") ||
            (@board[0][row_or_column] == @board[1][row_or_column] && @board[1][row_or_column] == @board[2][row_or_column] && @board[0][row_or_column] == "x") ||
            (@board[0][0] == @board[1][1] && @board[1][1] == @board[2][2] && @board[0][0] == "x") ||
            (@board[0][2] == @board[1][1] && @board[1][1] == @board[2][0] && @board[0][2] == "x")
        @winner = @player2
        break
      else
        @winner = nil
      end
    end
    @winner
  end

  private

  def introduce_players                                                        # introduce players
    puts "\nPodajcie swoje imiona: "
    print "Gracz 1: "
    @player1 = STDIN.gets.chomp
    while @player1 == "" do
      print "Graczu 1: wpisz swoje imię: "
      @player1 = STDIN.gets.chomp
    end
    print "Gracz 2: "
    @player2 = STDIN.gets.chomp
    while @player2 == "" do
      print "Graczu 2: wpisz swoje imię: "
      @player2 = STDIN.gets.chomp
    end
    puts "\n@#{@player1}, będziesz stawiać kółka (o) \n@#{@player2}, będziesz stawiać krzyżyki (x) \n\nCzas zacząć grę, powodzenia! :)\n\n"
    true
  end

  def translate_given_cell_to_board_address
    @address_row = (@given_cell.chars.last.to_i - 3).abs
    @address_column = translate(@given_cell.chars.first.upcase)                 #as in chess board -> A1 is in the third row and 1 column, C2 is in the second row and third column
    true
  end

  def translate(address)
    case address
    when "A"
      0
    when "B"
      1
    when "C"
      2
    end
  end

  def draw_gameboard
    3.times do |row| #rows
      print "-------------" #top border
      puts
      3.times do |column|
        if @board[row][column] == nil
          print "|   "
        else
          print "| " + @board[row][column].to_s + " "  #cells
        end
      end
      print "|" #right border
      puts
    end
    print "-------------" #bottom border
    true
  end

  def fill_in_gameboard(given_row, given_column, given_sign)
    @board[given_row][given_column] = given_sign
    draw_gameboard
    true
  end

end
