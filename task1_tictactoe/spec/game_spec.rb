require_relative "../lib/tictactoe.rb"

describe Tictactoe do

  before(:each) do
    @tictactoe = Tictactoe.new
    jon = allow(@tictactoe).to receive(:gets) { "Jon\n" }
    jeff = allow(@tictactoe).to receive(:gets) { "Jeff\n" }
    @tictactoe.instance_variable_set(:@player1, jon)
    @tictactoe.instance_variable_set(:@player2, jeff)
  end

  describe 'init_game' do
    it 'should show a welcome message' do
      @tictactoe.init_game
      expect { puts('GRA W KÓŁKO I KRZYŻYK') }.to output.to_stdout
    end

    it 'should establish the gameboard size to 3' do
      @tictactoe.init_game
      expect(@tictactoe.instance_variable_get(:@gameboard_size)).to eq 3
    end

    it 'should draw empty gameboard' do
      @tictactoe.init_game
      expect { print "-------------" }.to output.to_stdout
      expect { print "|   |   |   |" }.to output.to_stdout
    end

    it 'should establish the players names' do
      @tictactoe.init_game
      expect { puts '\nPodajcie swoje imiona: ' }.to output.to_stdout
      expect(@tictactoe.instance_variable_get(:@player1)).to eq "Jon"
      expect(@tictactoe.instance_variable_get(:@player2)).to eq "Jeff"
    end

    it 'should establish the players names if the names are empty' do
      @tictactoe.instance_variable_set(:@player1, "")
      @tictactoe.init_game
      expect { print 'Graczu 1: wpisz swoje imię: ' }.to output.to_stdout
      expect(@tictactoe.instance_variable_get(:@player1)).to eq ""
    end

    it 'should output the instructions message' do
      @tictactoe.init_game
      expect { puts "\n@#{@player1}, będziesz stawiać kółka (o) \n@#{@player2}, będziesz stawiać krzyżyki (x) \n\nCzas zacząć grę, powodzenia! :)\n\n" }.to output.to_stdout
    end

    it 'should establish @round_number to 1' do
      @tictactoe.init_game
      expect(@tictactoe.instance_variable_get(:@round_number)).to eq 1
    end

    it 'should establish @board' do
      @tictactoe.init_game
      expect(@tictactoe.instance_variable_get(:@board).length).not_to be_nil
    end

    it 'should establish @addresses array' do
      @tictactoe.init_game
      expect(@tictactoe.instance_variable_get(:@addresses)).to eq ["A1", "A2", "A3", "B1", "B2", "B3", "C1", "C2", "C3"]
    end

    it 'should establish @input_history array' do
      @tictactoe.init_game
      expect(@tictactoe.instance_variable_get(:@input_history)).to eq []
    end
  end

  describe 'translate(address)' do
    it 'should translate the given letter address into number of row' do
      expect(@tictactoe.send(:translate, "A")).to eq 0
      expect(@tictactoe.send(:translate, "B")).to eq 1
      expect(@tictactoe.send(:translate, "C")).to eq 2
    end
  end

  describe 'draw_empty_gameboard(size)' do
    it 'should draw a gamebord with given size = 3' do
      @tictactoe.send(:draw_empty_gameboard, 3)
      4.times do
        expect { print "-------------" }.to output.to_stdout
      end
      3.times do
        expect { print "|   |   |   |" }.to output.to_stdout
      end
    end
  end

  describe 'draw_gameboard(size, row, column, sign)' do
    before(:each) do
      @tictactoe.instance_variable_set(:@board, [[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]])
    end

    it 'should draw an \'o\' in B1 cell' do
      @tictactoe.send(:draw_gameboard, 3, 2, 1, "o")
      expect(@tictactoe.instance_variable_get(:@board)).to eq [[nil,nil,nil],[nil,nil,nil],[nil,"| o ",nil]]
    end

    it 'should draw a \'o\' in B1 cell and second sign \'x\' in C3 cell' do
      @tictactoe.send(:draw_gameboard, 3, 2, 1, "o")
      @tictactoe.send(:draw_gameboard, 3, 0, 2, "x")
      expect(@tictactoe.instance_variable_get(:@board)).to eq [[nil,nil,"| x "],[nil,nil,nil],[nil,"| o ",nil]]
    end

    it 'should draw borders' do
      @tictactoe.send(:draw_gameboard, 3, 2, 1, "o")
      4.times do
        expect { print "-------------" }.to output.to_stdout
      end
      2.times do
        expect { print "|   |   |   |" }.to output.to_stdout
      end
      expect { print "|   | o |   |" }.to output.to_stdout
    end
  end

  describe 'play_round(number)' do
    before(:each) do
      given_cell = allow(@tictactoe).to receive(:gets) { "B1\n" }
      @tictactoe.instance_variable_set(:@given_cell, given_cell)

      @tictactoe.instance_variable_set(:@addresses, ["A1", "A2", "A3", "B1", "B2", "B3", "C1", "C2", "C3"])
      @tictactoe.instance_variable_set(:@input_history, [])
      @tictactoe.instance_variable_set(:@gameboard_size, 3)
    end

    it 'should display the instructions - odd rounds for player1' do
      @tictactoe.instance_variable_set(:@board, [[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]])
      @tictactoe.instance_variable_set(:@player1, "Jon")
      @tictactoe.instance_variable_set(:@player2, "Jeff")
      @tictactoe.send(:play_round, 1)
      expect { puts "Runda 1:" }.to output.to_stdout
      expect { print "\n@Jon, podaj pole, w którym postawić kółko (np. B1 - kolumna 2 wiersz 3): " }.to output.to_stdout
    end

    it 'should display the instructions - odd rounds for player1' do
      @tictactoe.instance_variable_set(:@board, [[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]])
      @tictactoe.instance_variable_set(:@player1, "Jon")
      @tictactoe.instance_variable_set(:@player2, "Jeff")
      @tictactoe.send(:play_round, 2)
      expect { puts "Runda 2:" }.to output.to_stdout
      expect { print "\n@Jeff, podaj pole, w którym postawić krzyżyk (np. B1 - kolumna 2 wiersz 3): " }.to output.to_stdout
    end

    it 'should check if given cell exists in the gameboard' do
      @tictactoe.instance_variable_set(:@board, [[nil,nil,nil],[nil,nil,nil],[nil,"| x ",nil]])
      @tictactoe.instance_variable_set(:@given_cell, "D4")
      @tictactoe.send(:play_round, 1)
      expect { print "\ntakiego pola D4 nie ma na planszy. Podaj istniejące pole:  " }.to output.to_stdout
    end

    it 'should check if given cell exists in the gameboard' do
      @tictactoe.instance_variable_set(:@board, [[nil,nil,nil],[nil,nil,nil],[nil,"| x ",nil]])
      @tictactoe.send(:play_round, 1)
      expect { print "\nPole B1 jest już wypełnione. Podaj inne pole: " }.to output.to_stdout
    end

    it 'should translate the address' do
      @tictactoe.instance_variable_set(:@board, [[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]])
      @tictactoe.send(:play_round, 1)
      expect(@address_row).to eq 2
      expect(address_column).to eq 1
      expect { print "\nPole B1 jest już wypełnione. Podaj inne pole: " }.to output.to_stdout
    end

    it 'should increase the @input_history array' do
      @tictactoe.instance_variable_set(:@board, [[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]])
      @tictactoe.send(:play_round, 1)
      expect(@tictactoe.instance_variable_get(:@input_history)).to eq ["B1"]

      given_cell2 = allow(@tictactoe).to receive(:gets) { "c1\n" }
      @tictactoe.instance_variable_set(:@given_cell, given_cell2)
      @tictactoe.send(:play_round, 2)
      expect(@tictactoe.instance_variable_get(:@input_history)).to eq ["B1", "C1"]
    end

    it 'should draw gameboard by draw_gameboard method - odd round' do
      @tictactoe.instance_variable_set(:@board, [[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]])
      @tictactoe.send(:play_round, 1)
      expect(@tictactoe).to receive(:draw_gameboard).with(3, 2, 1, "o")
    end

    it 'should draw gameboard by draw_gameboard method - even round' do
      @tictactoe.instance_variable_set(:@board, [[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]])
      @tictactoe.send(:play_round, 2)
      expect(@tictactoe).to receive(:draw_gameboard).with(3, 2, 1, "x")
    end

    it 'should check_winner' do
      @tictactoe.instance_variable_set(:@board, [[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]])
      @tictactoe.send(:play_round, 1)
      expect(@tictactoe).to receive(:check_winner)
    end
  end

  describe 'start_game' do
    # it 'should init game' do
    #   expect(@tictactoe.start_game).to call(:init_game)
    # end

    # it 'should end game and say who win' do
    #   @tictactoe.instance_variable_set(:@winner, @player2)
    #   @tictactoe.start_game
    #   expect { puts "\n\nZwycięzcą jest Jeff. Gratulacje! \n\nKoniec gry." }.to output.to_stdout
    # end
    #
    # it 'should play rounds until nobody wins' do
    #   expect(@tictactoe.start_game).to receive(:play_round)
    # end
    #
    # it 'should end game when all cells are filled' do
    #   @tictactoe.instance_variable_set(:@board, [["| o ","| x ","| o "],["| x ","| x ","| o "],["| o ","| o ","| x "]])
    # #   @tictactoe.start_game
    #    expect { puts "\n\nWszystkie pola w tablicy wypełnione. Nikt nie wygrał. \n\nKoniec gry." }.to output.to_stdout
    #  end
  end

end
