ENV['RACK_ENV'] = 'test'

require './logic.rb'
require 'rspec'
require 'rack/test'

describe "./logic.rb" do
  include Rack::Test::Methods

  describe "categorize_cells" do
    let(:inputted_checked_cells) { ['0_17','1_17','2_17'] }

    it "categorize cells to living and died" do
      categorize_cells(inputted_checked_cells)
      expect(@living_cells).to eq ['0_17', '1_17', '2_17']
      expect(@died_cells).to include '0_7', '3_12'
    end
  end

  describe "find_neighbours(cell)" do
    before(:each) do
      @neighbours = []
    end
    it "finds all neigbours of given cell" do
      expect(find_neighbours('3_15')).to eq([['2_15', '4_15', '3_14', '3_16', '2_14', '2_16', '4_14', '4_16']])
    end
  end

  describe "count_living_neighbours(cell)" do
    before(:each) do
      @neighbours = [['2_15', '4_15', '3_14', '3_16', '2_14', '2_16', '4_14', '4_16']]
      @living_cells = ['3_14', '3_15', '4_15']
    end
    it "counts the living_neighbours" do
      expect(count_living_neighbours('3_15')).to eq 2
    end
  end

  describe "decide_the_next_iteration(living_cells, died_cells)" do
    before do
      @living_cells = ['1_3','2_3','3_3']
      @died_cells = ['0_1', '0_2', '0_3', '0_4', '1_1', '1_2', '1_4', '2_1', '2_2', '2_4', '3_1', '3_2', '3_4', '4_1', '4_2', '4_3', '4_4']
    end

    it "decides which cells will be checked in the next iteration" do
      expect(decide_the_next_iteration(@living_cells, @died_cells).sort).to eq(['2_2', '2_3', '2_4'])
    end
  end

end
