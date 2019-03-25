
require 'rails_helper'

describe HomeController do
  describe 'Get #top' do
    before do
      get :new
    end
    it "リクエストは200 OK となること" do
      expect(response.status).to eq 200
    end
  end
end