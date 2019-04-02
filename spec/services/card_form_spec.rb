
require 'rails_helper'
require 'card_form'

describe CardForm do
  describe '#valid?' do
    context "6文字以上の場合" do
      it "エラー文を表示する" do
        card = CardForm.new(["H1","H2","H3","H4","H5","H6"])
        card.valid?
        expect(card.errors).to eq ["5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）"]
      end
    end

    context "同じカードが重複している場合" do
      it "エラー文を表示する" do
        card = CardForm.new(["H1", "H1", "H2", "H3", "H4"])
        card.valid?
        expect(card.errors).to eq ["カードが重複しています。"]
      end
    end

    context "カードの数字が無効な場合" do
      it "エラー文を表示する" do
        card = CardForm.new(["H1", "H2", "H3", "H4", "H14"])
        card.valid?
        expect(card.errors).to eq ["5番目のカード指定文字が不正です。(H14)", "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"]
      end
    end

    context "カードのスートが無効な場合" do
      it "エラー文を表示する" do
        card = CardForm.new(["H1", "H2", "H3", "H4", "F5"])
        card.valid?
        expect(card.errors).to eq ["5番目のカード指定文字が不正です。(F5)", "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"]
      end
    end
  end

  describe '#check' do
    it "ストレートフラッシュ" do
      card = CardForm.new(["H1", "H2","H3", "H4", "H5"])
      card.check
      expect(card.role).to eq "ストレートフラッシュ"
    end

    it "フラッシュ" do
      card = CardForm.new(["H1", "H2","H3", "H4", "H6"])
      card.check
      expect(card.role).to eq "フラッシュ"
    end

    it "ストレート" do
      card = CardForm.new(["C1", "H2","H3", "H4", "H5"])
      card.check
      expect(card.role).to eq "ストレート"
    end

    it "フォーカード" do
      card = CardForm.new(["H1", "C1","D1", "S1", "H6"])
      card.check
      expect(card.role).to eq "フォーカード"
    end

    it "スリーカード" do
      card = CardForm.new(["H1", "C1","D1", "H4", "H6"])
      card.check
      expect(card.role).to eq "スリーカード"
    end

    it "フルハウス" do
      card = CardForm.new(["H1", "C1","D1", "C6", "H6"])
      card.check
      expect(card.role).to eq "フルハウス"
    end

    it "ツーペア" do
      card = CardForm.new(["H1", "C1","H3", "C3", "H6"])
      card.check
      expect(card.role).to eq "ツーペア"
    end

    it "ワンペア" do
      card = CardForm.new(["H1", "C1","H3", "H4", "H6"])
      card.check
      expect(card.role).to eq "ワンペア"
    end

    it "ハイカード" do
      card = CardForm.new(["H1", "H2","H3", "H4", "C6"])
      card.check
      expect(card.role).to eq "ハイカード"
    end
  end

end
