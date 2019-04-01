require 'rails_helper'


describe "POST /api/v1/judge" do
  context 'パターン１' do
    before do
      post "/api/v1/judge", params: { "cards": [ "H1 H13 H12 H11 H9", "H9 C9 S1 H2 C2", "C13 D12 C11 H8 H7" ] }
    end

    it '201が返ってくる' do

      expect(response.status).to eq 201
    end


    it '結果を返す' do
      params = { "cards": [ "H1 H13 H12 H11 H9", "H9 C9 S1 H2 C2", "C13 D12 C11 H8 H7" ] }
      expect(JSON.parse(response.body, {symbolize_names: true})).to eq [
                                   {
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
                               ]
    end
  end

  context 'パターン2' do
    before do
      post "/api/v1/judge", params: { "cards": [ "H1 H13 H12 H11 H10", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H15" ] }
    end

    it '結果を返す' do
      expect(JSON.parse(response.body, {symbolize_names: true})).to eq [
                                                                           {
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
                                                                       ]
    end
  end




end

