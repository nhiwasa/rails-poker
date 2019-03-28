require 'rails_helper'


describe "POST /api/v1/judge" do
  before do
    post "/api/v1/judge", let(:params) { { "cards": [ "H1 H13 H12 H11 H9", "H9 C9 S1 H2 C2", "C13 D12 C11 H8 H7" ] } }
  end

  it '201が返ってくる' do
    expect(response.status).to eq 201
  end

  it '結果を返す' do

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

  it '結果を返す' do

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

