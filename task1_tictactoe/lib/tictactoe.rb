class Tictactoe

  def start_game
    init_game  #load the setup

    while @winner == nil
      play_round @round_number
      @round_number += 1
      if (@board.all? { |cell| cell.all? { |e| e != nil } })
        puts "\n\nWszystkie pola w tablicy wypełnione. Nikt nie wygrał. \n\nKoniec gry."
        break
      end
    end

    if @winner != nil
      puts "\n\nZwycięzcą jest #{@winner}. Gratulacje! \n\nKoniec gry."
    end
  end

  def init_game
    puts "\nGRA W KÓŁKO I KRZYŻYK"
    @gameboard_size = 3
    draw_empty_gameboard(@gameboard_size)

    puts "\nPodajcie swoje imiona: "
    print "Gracz 1: "
    @player1 = gets.chomp
    while @player1 == "" do
      print "Graczu 1: wpisz swoje imię: "
      @player1 = gets.chomp
    end
    print "Gracz 2: "
    @player2 = gets.chomp
    while @player2 == "" do
      print "Graczu 2: wpisz swoje imię: "
      @player2 = gets.chomp
    end
    puts "\n@#{@player1}, będziesz stawiać kółka (o) \n@#{@player2}, będziesz stawiać krzyżyki (x) \n\nCzas zacząć grę, powodzenia! :)\n\n"

    @round_number = 1  #every new round will increment this number by 1 and the odd rounds are for prayer1 and the even for player2
    @board = Array.new(@gameboard_size) { Array.new(@gameboard_size)} # 2-dimensional array to fill with "x" and "o"
    @addresses = ["A1", "A2", "A3", "B1", "B2", "B3", "C1", "C2", "C3"] #dictionary of proper cell addresses from user input
    @input_history = [] #a table to collect user inputs to check if the same cell isn't inputted twice
  end

  private

  def play_round(number)
    puts "\n\nRunda #{number}:\n"
    print "\n@#{@player1}, podaj pole, w którym postawić kółko (np. B1 - kolumna 2 wiersz 3): " if number.odd?
    print "@#{@player2}, podaj pole, w którym postawić krzyżyk (np. B1 - kolumna 2 wiersz 3): " if number.even?

    given_cell = gets.chomp
    until ( @addresses.find {|address| address == given_cell.upcase } ) != nil
      print "\ntakiego pola #{given_cell.upcase} nie ma na planszy. Podaj istniejące pole: "
      given_cell = gets.chomp
    end
    while @input_history.index(given_cell.upcase) != nil
      print "\nPole #{given_cell.upcase} jest już wypełnione. Podaj inne pole: "
      given_cell = gets.chomp
    end

    @input_history << given_cell.upcase

    address_row = (given_cell.chars.last.to_i - 3).abs          #this and next lines translates user input into @board (2-dimensional array) cells
    address_column = translate given_cell.chars.first.upcase    #as in chess board -> A1 is in the third row and 1 column, C2 is in the second row and third column 


    draw_gameboard(@gameboard_size, address_row, address_column, "o") if number.odd?
    draw_gameboard(@gameboard_size, address_row, address_column, "x") if number.even?

    check_winner
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

  def draw_empty_gameboard(size)
    size.times do  #rows
      print "-------------" #top border
      puts
      size.times do
        print "|   "  #cells
      end
      print "|" #right border
      puts
    end
    print "-------------" #bottom border
  end

  def draw_gameboard(size, given_row, given_column, given_sign)
    size.times do |row| #rows
      print "-------------" #top border
      puts
      size.times do |column| #cells
        if given_row == row && given_column == column
          if @board[row][column] != nil     #if sth has been inputted in the cell inthe past it shouldn't be overwritten
            print @board[row][column]
          else
            @board[row][column] = "| #{given_sign} "
            print @board[row][column]
          end
        else
          if @board[row][column] != nil     #if sth has been inputted in the cell inthe past it shouldn't be overwritten
            print @board[row][column]
          else
            print "|   "
          end
        end
      end
      print "|" #right border
      puts
    end
    print "-------------" #bottom border
  end

  def check_winner
    [0,1,2].each do |row_or_column|
      if (@board[row_or_column][0] == @board[row_or_column][1] && @board[row_or_column][1] == @board[row_or_column][2] && @board[row_or_column][0] == "| o ") ||
         (@board[0][row_or_column] == @board[1][row_or_column] && @board[1][row_or_column] == @board[2][row_or_column] && @board[0][row_or_column] == "| o ") ||
         (@board[0][0] == @board[1][1] && @board[1][1] == @board[2][2] && @board[0][0] == "| o ") ||
         (@board[0][2] == @board[1][1] && @board[1][1] == @board[2][0] && @board[0][2] == "| o ")
        @winner = @player1
        break
      elsif (@board[row_or_column][0] == @board[row_or_column][1] && @board[row_or_column][1] == @board[row_or_column][2] && @board[row_or_column][0] == "| x ") ||
            (@board[0][row_or_column] == @board[1][row_or_column] && @board[1][row_or_column] == @board[2][row_or_column] && @board[0][row_or_column] == "| x ") ||
            (@board[0][0] == @board[1][1] && @board[1][1] == @board[2][2] && @board[0][0] == "| x ") ||
            (@board[0][2] == @board[1][1] && @board[1][1] == @board[2][0] && @board[0][2] == "| x ")
        @winner = @player2
        break
      else
        @winner = nil
      end
    end
    @winner
  end

end
