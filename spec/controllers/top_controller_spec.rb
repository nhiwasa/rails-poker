
require 'rails_helper'

describe HomeController do
  describe 'Get #top' do
    before do
      get :top
    end

    it "リクエストは200 OK となること" do
      expect(response.status).to eq 200
    end

    it ":topテンプレートを表示すること" do
      expect(response).to render_template :top
    end
  end

  describe 'Post #top' do
    context 'パラメータが入力された場合' do
      before do
        post :judge, params: {cards: "H1 H2 H3 H4 H5"}
      end

      it 'リクエストは200 OK となること' do
        expect(response.status).to eq 200
      end

      it ':judgeテンプレートを表示すること' do
        expect(response).to render_template :judge
      end
    end

  end
end