ENV['RACK_ENV'] = 'test'

require './app.rb'
require 'rspec'
require 'rack/test'

describe "./app.rb" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "GET /" do
    it "renders index view" do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to include "Pozaznaczaj komórki"
    end
  end

  describe "POST /next" do
    context "params[:checked_cell] not nil" do
      let(:params){
        {living_cells: nil, died_cells: nil, living_cells: ['3_14', '3_15', '4_15'] }
      }
      before(:each) do
        post '/next', :checked_cell => ['3_14', '3_15', '4_15']
      end
      it 'calls categorize_cells method' do
        expect(last_request).to receive(:categorize_cells).once
      end
      it 'calls decide_the_next_iteration method' do
        expect(last_request).to receive(:decide_the_next_iteration).once
      end
      it 'renders next view' do
        expect(last_response).to be_ok
        expect(last_response.body).to include 'Klikając przycisk'
      end
    end
    context "params[:checked_cell] is nil" do
      before(:each) do
        post '/next', :checked_cell => nil
      end
      it "assigns flash[:notice] message" do
        expect(last_response.redirect?).to eq true
        follow_redirect!
        expect(last_response.body).to include "Wszystkie komórki umarły. Zaczynamy nową grę"
      end
      it 'redirects to /' do
        expect(last_response.redirect?).to eq true
        follow_redirect!
        expect(last_request.path).to eq('/')
      end
    end
  end

  describe "categorize_cells" do
    before(:each) do
      params[:living_cells] = ['0_17','1_17','2_17']
    end
    it "categorize cells to living and died" do
      categorize_cells
      expect(params[:living_cells]).to eq ['3_14', '3_15', '4_15']
      expect(params[:died_cells]).to include ['3_12', '0_7']
    end
  end

  describe "decide_the_next_iteration" do
    before(:each) do
      params[:living_cells] = ['0_17','1_17','2_17']
    end
    it "decides which cells will be checked in the next iteration" do
      expect(decide_the_next_iteration).to eq(['1_16', '1_17', '1_18'])
    end
  end

  describe "count_living_neighbours" do
    before(:each) do
      @neighbours = [['2_15', '4_15', '3_14', '3_16', '2_14', '2_16', '4_14', '4_16']]
      allow(app).to receive(params) and return({living_cells: ['3_14', '3_15', '4_15']})
      @living_neighbours_count = 0
    end
    it "counts the living_neighbours" do
      expect(count_living_neighbours).to eq 2
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
end
