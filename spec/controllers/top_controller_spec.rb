

describe 'valid?' do
  context "５文字以上の場合" do
   it "エラー文を表示する" do
     card = CardForm.new(["H1","H2","H3","H4","H5","H6"])
     expect(card.valid?).to eq "5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）"
   end
  end

end