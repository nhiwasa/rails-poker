require 'rails_helper'


describe "POST /api/v1/judge" do
  context '正しく入力された時' do
    before do
      post "/api/v1/judge", params: { "cards": [ "H1 H13 H12 H11 H9", "H9 C9 S1 H2 C2", "C13 D12 C11 H8 H7" ] }
      @expect = {
          "result": [
              {
                  "card": "H1 H13 H12 H11 H9",
                  "hand": "フラッシュ",
                  "best": true
              },
              {
                  "card": "H9 C9 S1 H2 C2",
                  "hand": "ツーペア",
                  "best": false
              },
              {
                  "card": "C13 D12 C11 H8 H7",
                  "hand": "ハイカード",
                  "best": false
              }
          ]
      }

    end

    it '201が返ってくる' do

      expect(response.status).to eq 201
    end


    it '結果を返す' do
      expect(JSON.parse(response.body, {symbolize_names: true})).to eq [@expect]
    end
  end

  context 'パラメータが間違っていたとき' do
    before do
      post "/api/v1/judge", params: { "cards": [ "H1 H13 H12 H11 H10", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H15" ] }
      @expect = {
          "result": [
              {
                  "card": "H1 H13 H12 H11 H10",
                  "hand": "ストレートフラッシュ",
                  "best": true
              },
              {
                  "card": "H9 C9 S9 H2 C2",
                  "hand": "フルハウス",
                  "best": false
              },
              {
                  "card": "C13 D12 C11 H8 H15",
                  "msg": "5番目のカード指定文字が不正です。(H15)",
                  "best": false
              }
          ]
      }
    end

    it '結果を返す' do
      expect(JSON.parse(response.body, {symbolize_names: true})).to eq [@expect]
    end
  end

  context "URLが正しくない場合" do
    before do
      post "/api/v1/jud", params: { "cards": [ "H1 H13 H12 H11 H10", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H15" ]}
      @expect = {error: [{msg: "不正なURLです。"}]}
    end

    it '404が返ってくる' do
      expect(response.status).to eq 404
    end

    it "不正なURLです。が返ってくる" do
      expect(JSON.parse(response.body, {symbolize_names: true})).to eq @expect
    end
  end

  context "リクエストが渡らなかった場合" do
    before do
      post "/api/v1/judge", params: { }
      @expect = {error: [{msg: "予測しないエラーです。"}]}
    end

    it '500が返ってくる' do
        expect(response.status).to eq 500
    end

    it "予測しないエラーです。が返ってくる" do
      expect(JSON.parse(response.body, {symbolize_names: true})).to eq @expect
    end
  end






end

