require_relative "../lib/tictactoe.rb"

describe Tictactoe do

  # let(:ttt) { Tictactoe.new }
  # let(:ttts) { TictactoeSupport.new }
  before(:each) do
    @ttt = double("tictactoe")
    @ttts = double("tictactoesupport")
  end

  describe 'play_game' do
    it 'should init new game' do
      @ttt.play_game
      expect(@ttt.play_game).to receive(:init_new_game)
    end

    it 'should play until there is no winner and there are empty cells in gameboard' do
      allow(@ttts).not_to receive(:winner?)
      allow(@ttts).not_to receive(:all_cells_filled?)
      @ttts.instance_variable_set(round_number, 1)
      expect(@ttt.play_game).to receive(@ttts.play_round).with(1)
      expect(@ttt.play_game).to change(@ttts.round_number).by(1)
    end

    it 'should end game if there is a winner' do
      allow(@ttts).to receive(:winner?) { "Jon" }
      expect(@ttt.play_game).to receive(@ttts.end_game_if_all_cells_filled) { "\n\nZwycięzcą jest Jon. Gratulacje! \n\nKoniec gry." }
    end

    it 'should end game if there are no empty cells in gameboard' do
      allow(@ttts).to receive(:all_cells_filled?) { true }
      expect(@ttt.play_game).to receive(@ttts.end_game_if_all_cells_filled) { "\n\nWszystkie pola w tablicy wypełnione. Nikt nie wygrał. \n\nKoniec gry."}
    end
  end
  #
  # def play_game                                                                # play one whole game
  #   @ttt = TictactoeSupport.new
  #   @ttt.init_new_game                                                         # load the setup, introduce players etc
  #
  #   until @ttt.winner? || @ttt.all_cells_filled?                               # while there isn't winner and there are empty cells on board we play
  #     play_round(@ttt.round_number)
  #     @ttt.round_number += 1
  #   end
  #
  #   if @ttt.winner?                                                            # if there is winner, the winner is awarded, game over
  #     @ttt.end_game_when_there_is_winner
  #   elsif @ttt.all_cells_filled?                                               # if there isn't winner and empty cells on board, nobody wins, game over
  #     @ttt.end_game_if_all_cells_filled
  #   end
  # end
  #
  # private
  #
  # def play_round(number)                                                       # play one round of the game
  #
  #   @ttt.init_round                                                            # puts the round number
  #   @ttt.ask_user_to_choose_cell                                               # asks user to input the cell to put o or x
  #
  #   until @ttt.given_cell_available?                                           # checks if the given cell exist and is empty
  #     @ttt.put_message_about_cell_unavailability_to_user                       # if not, the user see why can't write o or x in the pointed cell
  #     @ttt.ask_user_to_choose_cell                                             # and is asked to choose other cell
  #   end
  #
  #   if @ttt.given_cell_available?                                              # if the pointed cell is empty the user can write his/her sign into this cell
  #     @ttt.put_sign_on_gameboard("o") if number.odd?                           # the sign is inputted
  #     @ttt.put_sign_on_gameboard("x") if number.even?
  #     @ttt.actualize_input_history                                             # the input history is growing by the cell where the sign is inputted (this cell begin unavailable)
  #     @ttt.check_winner                                                        # the program checks if there is winner
  #   end
  # end


end
