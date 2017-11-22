class Tictactoe
  def run
    init_game
    play_round 1
  end

  def init_game #starts the game and welcome players
    puts "\nGra w kółko i krzyżyk"
    print "Podajcie rozmiar planszy: "
    size = gets.chomp.to_i
    draw_empty_gameboard(size)
    puts "\nPodajcie swoje imiona: "
    print "Gracz 1: "
    @player1 = gets.chomp
    print "Gracz 2: "
    @player2 = gets.chomp
    puts "\n@#{@player1}, będziesz stawiać kółka (o) \n@#{@player2}, będziesz stawiać krzyżyki (x) \n\nCzas zacząć grę, powodzenia! :)"
  end

  def play_round(number) #plays one round of the game
    puts "Runda #{number}"
    puts "\nPola oznaczamy nazwą wiersza i nazwą kolumny licząc od 1, np. A1 - wiersz 1 i kolumna 1, C2 - wiersz 3 i kolumna 2\n"
    puts "#{@player1}, wybierz pole, w którym postawić kółko"
    pool = gets.chomp

  end

  private

  def draw_empty_gameboard(gameboard_size) #draws an empty gameboard of given size (rows and coulmns count)
    board_size = gameboard_size * 2 #a board_size local variable

    gameboard_size.times do #draws a table by rows, a table has the same rows and columns, empty rows are omitted
      0.step(board_size,2) { print "---" }
      (gameboard_size-2).times { print "-" }
      puts
      1.step(board_size,2) { print "|   " }
      print "|"
      puts
    end
    0.step(board_size,2) { print "---" }
    (gameboard_size-2).times { print "-" }
    puts 
    #name_gameboard_pools(gameboard_size)
  end

  def name_gameboard_pools(board_size) #gives names to the gameboard pools

  end
end
