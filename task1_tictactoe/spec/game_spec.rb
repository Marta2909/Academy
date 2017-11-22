require_relative "../../task1/lib/tictactoe.rb"

describe Tictactoe do
  describe "draw_empty_gameboard(gameboard_size)" do
    it "should draw an empty gameboard" do
      expect(Tictactoe.new.draw_empty_gameboard(3)).to be_nil
    end
  end

  describe "init_game" do
    it "should get the players names" do
      Tictactoe.new.init_game
      expect(@player1).not_to be_nil
      expect(@player2).not_to be_nil
    end
    it "should welcome the players and wish good luck" do
      expect(Tictactoe.new.init_game).to have "powodzenia"
    end
  end
end
