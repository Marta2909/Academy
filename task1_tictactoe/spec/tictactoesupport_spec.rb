require_relative "../lib/tictactoesupport.rb"

describe TictactoeSupport do

  let(:ttts) { TictactoeSupport.new }

  before(:each) do
    jon = allow(ttts).to receive(:gets) { "Jon\n" }
    jeff = allow(ttts).to receive(:gets) { "Jeff\n" }
    ttts.instance_variable_set(:@player1, jon)
    ttts.instance_variable_set(:@player2, jeff)
  end

  describe 'init_new_game' do
    before(:each) do
      ttts.init_new_game
    end

    it 'should display a welcome with the game title' do
      expect { puts "\nGRA W KÓŁKO I KRZYŻYK" }.to output.to_stdout
    end

    it 'should establish an @board variable' do
      expect(ttts.instance_variable_get(:@board)).to eq Array.new(3) { Array.new(3) }
    end

    it 'should establish an @addresses array' do
      expect(ttts.instance_variable_get(:@addresses)).to eq ["A1", "A2", "A3", "B1", "B2", "B3", "C1", "C2", "C3"]
    end

    it 'should establish an @input_history variable' do
      expect(ttts.instance_variable_get(:@input_history)).to eq []
    end

    it 'should establish a @round_number variable' do
      expect(ttts.instance_variable_get(:@round_number)).to eq 1
    end

    it 'should draw an empty gameboard' do
      expect{ ttts.send(:draw_gameboard) }.to output.to_stdout
    end

    it 'should introduce players' do
      expect{ ttts.send(:introduce_players) }.to output.to_stdout
    end
  end

  describe 'winner?' do
    it 'should return false if there is no winner' do
      expect(ttts.winner?).to be false
    end

    it 'should return true if there is a winner' do
      ttts.instance_variable_set(:@winner, ttts.instance_variable_get(:@player1))
      expect(ttts.winner?).to be true
    end
  end

  describe 'end_game_when_there_is_winner' do
    it 'should inform that there is a winner and congratulate him/her' do
      ttts.instance_variable_set(:@winner, ttts.instance_variable_get(:@player1))
      ttts.end_game_when_there_is_winner
      expect { puts "\n\nZwycięzcą jest Jon. Gratulacje! \n\nKoniec gry." }.to output.to_stdout
    end
  end

  describe 'end_game_if_all_cells_filled' do
    it 'should inform that all cells are filled and there is no winner' do
      ttts.end_game_if_all_cells_filled
      expect { puts "\n\nWszystkie pola w tablicy wypełnione. Nikt nie wygrał. \n\nKoniec gry." }.to output.to_stdout
    end
  end

  describe 'init_round' do
    it 'should introduce a new round with number' do
      ttts.instance_variable_set(:@round_number, 2)
      ttts.init_round
      expect { puts "\n\nRunda 2:\n"}.to output.to_stdout
    end
  end

  describe 'all_cells_filled?' do
    it 'should return true if all cells on gameboard are filled' do
      ttts.instance_variable_set(:@board, [["x","o","x"],["o","o","x"],["x","x","o"]])
      expect(ttts.all_cells_filled?).to be true
    end
    it 'should return false if not all cells on gameboard are filled' do
      ttts.instance_variable_set(:@board, [["x",nil,"x"],["o","o","x"],["x","x","o"]])
      expect(ttts.all_cells_filled?).to be false
    end
    it 'should return false if no cells on gameboard are filled' do
      ttts.instance_variable_set(:@board, [[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]])
      expect(ttts.all_cells_filled?).to be false
    end
  end

  describe 'ask_user_to_choose_cell' do
    it "should say to @player1 if the round_number is odd (\"o\")" do
      ttts.instance_variable_set(:@round_number, 1)
      ttts.ask_user_to_choose_cell
      expect { print "\n@Jon, podaj pole, w którym postawić kółko (np. B1 - kolumna 2 wiersz 3): " }.to output.to_stdout
    end

    it "should say to @player2 if the round_number is even (\"x\")" do
      ttts.instance_variable_set(:@round_number, 2)
      ttts.ask_user_to_choose_cell
      expect { print "@Jeff, podaj pole, w którym postawić krzyżyk (np. B1 - kolumna 2 wiersz 3): " }.to output.to_stdout
    end

    it 'should gets the input from stdin' do
      ttts.instance_variable_set(:@round_number, 2)
      allow(ttts).to receive(:gets) { "B2\n" }
      ttts.ask_user_to_choose_cell
      expect(ttts.instance_variable_get(:@given_cell)).to eq "B2"
    end
  end

  describe 'put_message_about_cell_unavailability_to_user' do
    it 'should inform user about the unavailability of inputted cell' do
      ttts.instance_variable_set(:@given_cell, "b2")
      ttts.put_message_about_cell_unavailability_to_user
      expect { puts "\nPola B2 nie ma lub jest wypełnione. Wybierz inne pole." }.to output.to_stdout
    end
  end

  describe 'given_cell_available?' do
    before (:each) do
      ttts.instance_variable_set(:@addresses, ["A1", "A2", "A3", "B1", "B2", "B3", "C1", "C2", "C3"])
    end

    it 'should return false if the given cell isn\'t in available addresses array' do
      ttts.instance_variable_set(:@given_cell, "b0")
      expect(ttts.given_cell_available?).to be false
    end

    it 'should return false if the given cell has been choosen earlier' do
      ttts.instance_variable_set(:@input_history, ["A1", "C3"])
      ttts.instance_variable_set(:@given_cell, "A1")
      expect(ttts.given_cell_available?).to be false
    end

    it 'should return true if the given cell is in available addresses and hasn\'t been choosen earlier' do
      ttts.instance_variable_set(:@input_history, ["A1", "C3"])
      ttts.instance_variable_set(:@given_cell, "B1")
      expect(ttts.given_cell_available?).to be true
    end
  end

  describe 'actualize_input_history' do
    it 'should save a given_cell into @input_history variable' do
      ttts.instance_variable_set(:@input_history, ["A1", "C3"])
      ttts.instance_variable_set(:@given_cell, "b1")
      ttts.actualize_input_history
      expect(ttts.instance_variable_get(:@input_history)).to eq ["A1", "C3", "B1"]
    end
  end

  describe 'put_sign_on_gameboard(sign)' do
    before(:each) do
      ttts.instance_variable_set(:@board, [[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]])
      ttts.instance_variable_set(:@given_cell, "b1")
    end

    it 'should translate the given cell into gameboard address' do
      ttts.put_sign_on_gameboard("o")
      expect(ttts.send(:translate_given_cell_to_board_address)).to be_truthy
    end

    it 'should fill the proper cell on gameboard with player\'s sign' do
      ttts.instance_variable_set(:@address_row, 1)
      ttts.instance_variable_set(:@address_column, 2)
      ttts.put_sign_on_gameboard("x")
      expect { ttts.send(:fill_in_gameboard, ttts.instance_variable_get(:@address_row),ttts.instance_variable_get(:@address_column),"x") }.to output.to_stdout
      ttts.send(:fill_in_gameboard, ttts.instance_variable_get(:@address_row),ttts.instance_variable_get(:@address_column),"x")
      expect(ttts.instance_variable_get(:@board)).to eq [[nil, nil, nil], [nil, nil, nil], [nil, "x", nil]]
    end
  end

  describe 'check_winner' do
    it 'should point a winner if whole row on gameboard have the same sign - player2 if x' do
      ttts.instance_variable_set(:@board, [["o","x",nil],[nil, nil, nil],["x","x","x"]])
      ttts.check_winner
      expect(ttts.instance_variable_get(:@winner)).to eq ttts.instance_variable_get(:@player2)
    end

    it 'should point a winner if whole row on gameboard have the same sign - player1 if o' do
      ttts.instance_variable_set(:@board, [["o","x",nil],["o","o","o"],[nil, nil, nil]])
      ttts.check_winner
      expect(ttts.instance_variable_get(:@winner)).to eq ttts.instance_variable_get(:@player1)
    end

    it 'should point a winner if whole column on gameboard have the same sign - player1 if o' do
      ttts.instance_variable_set(:@board, [["o","x",nil],["o",nil,"o"],["o", nil, nil]])
      ttts.check_winner
      expect(ttts.instance_variable_get(:@winner)).to eq ttts.instance_variable_get(:@player1)
    end

    it 'should point a winner if whole column on gameboard have the same sign - player2 if x' do
      ttts.instance_variable_set(:@board, [["o","x",nil],[nil,"x","o"],["o", "x", nil]])
      ttts.check_winner
      expect(ttts.instance_variable_get(:@winner)).to eq ttts.instance_variable_get(:@player2)
    end

    it 'should point a winner if A3,B2,C1 on gameboard have the same sign - player1 if o' do
      ttts.instance_variable_set(:@board, [["o","x",nil],[nil,"o","o"],["o", "x", "o"]])
      ttts.check_winner
      expect(ttts.instance_variable_get(:@winner)).to eq ttts.instance_variable_get(:@player1)
    end

    it 'should point a winner if A1,B2,C3 on gameboard have the same sign - player2 if x' do
      ttts.instance_variable_set(:@board, [[nil,"x","x"],[nil,"x","o"],["x","o","o"]])
      ttts.check_winner
      expect(ttts.instance_variable_get(:@winner)).to eq ttts.instance_variable_get(:@player2)
    end
  end

  describe 'introduce_players' do
    it 'should ask users to input their names' do
      expect { ttts.send(:introduce_players) }.to output.to_stdout
    end

    it 'should get @player1\'s name' do
      allow(ttts).to receive(:gets) { "Jon\n" }
      ttts.send(:introduce_players)
      expect(ttts.instance_variable_get(:@player1)).to eq "Jon"
    end

    it 'should get @player2\'s name' do
      allow(ttts).to receive(:gets) { "Jeff\n" }
      ttts.send(:introduce_players)
      expect(ttts.instance_variable_get(:@player2)).to eq "Jeff"
    end
  end

  describe 'translate(address)' do
    it 'should translate the given letter address into number of row' do
      expect(ttts.send(:translate, "A")).to eq 0
      expect(ttts.send(:translate, "B")).to eq 1
      expect(ttts.send(:translate, "C")).to eq 2
    end
  end

  describe 'translate_given_cell_to_board_address' do
    it 'should translate c3 to 13' do
      ttts.instance_variable_set(:@given_cell, "c3")
      ttts.send(:translate_given_cell_to_board_address)
      expect(ttts.instance_variable_get(:@address_row)).to eq 0
      expect(ttts.instance_variable_get(:@address_column)).to eq 2
    end
  end

  describe 'draw_gameboard' do
    it 'should draw an empty gameboard on stdout when @board is empty' do
      ttts.instance_variable_set(:@board, [[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]])
      ttts.send(:draw_gameboard)
      4.times do
        expect { print "-------------" }.to output.to_stdout
      end
      3.times do
        expect { print "|   |   |   |" }.to output.to_stdout
      end
    end

    it 'should draw an gameboard on stdout when @board is not empty' do
      ttts.instance_variable_set(:@board, [[nil,nil,nil],["o",nil,"x"],[nil,nil,nil]])
      ttts.send(:draw_gameboard)
      4.times do
        expect { print "-------------" }.to output.to_stdout
      end
      2.times do
        expect { print "|   |   |   |" }.to output.to_stdout
      end
      1.times do
        expect { print "| o |   | x |" }.to output.to_stdout
      end
    end
  end

  describe 'fill_in_gameboard(row, column, sign)' do
    before(:each) do
      ttts.instance_variable_set(:@board, [[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]])
      ttts.send(:fill_in_gameboard,1,2,"o")
    end

    it 'should add sign to @board variable' do
      expect(ttts.instance_variable_get(:@board)).to eq [[nil,nil,nil],[nil,nil,"o"],[nil,nil,nil]]
    end

    it 'should draw filled gameboard' do
      expect { ttts.send(:fill_in_gameboard,1,2,"o") }.to output.to_stdout
      4.times do
        expect { print "-------------" }.to output.to_stdout
      end
      2.times do
        expect { print "|   |   |   |" }.to output.to_stdout
      end
      1.times do
        expect { print "|   |   | o |" }.to output.to_stdout
      end
    end
  end
end
