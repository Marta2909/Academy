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

      before(:each) do
        post '/next', checked_cell: ['1_3','2_3','3_3']
      end

      it 'renders next view' do
        expect(last_response.body).to include 'Klikając przycisk'
      end
    end
    context "params[:checked_cell] is nil" do
      before(:each) do
        post '/next', checked_cell: nil
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

end
