class CardForm

  attr_reader :yaku
  attr_reader :errors

  def initialize(hand)
    @hands = hand
  end

  def valid?

    result = true
    @errors = []

    #５つ以外の手が入力された場合
    if @hands.count != 5
      @errors << "5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）"
      result = false
      return result
    #カードが重複している
    elsif @hands.uniq.count != 5
      @errors << "カードが重複しています。"
      result = false
      return result
    end

    @hands.each_with_index do |hand, i|
      number = hand[1..2].to_i
      if [*(1..13)].include?(number) == false
        @errors << "#{i+1}番目のカード指定文字が不正です。(#{hand})"
        result = false
      elsif ["S", "D", "C", "H"].include?(hand[0]) == false
        @errors << "#{i+1}番目のカード指定文字が不正です。(#{hand})"
        result = false
      end

    end

    if @errors.present?
      @errors << "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
    end

    return result
  end

  def check

      #スートと数の配列を作成
      @suits = []
      @numbers = []

      #入力された配列をアルファベットと数字に分ける
      @hands.each do |a|
        @suits.push a[0]
        @numbers.push a[1..2]
      end

      #numbersを数値に変換して昇順に並び替え
      numbers = @numbers.map{|x|x.to_i}.sort

      #重複している数をハッシュで表示したのち重複した要素の数を数える
      duplication = numbers.group_by{|x|x}.map{|k,v|v.count}.sort

      #スートの種類が一つ、かつ、数字が連続している(数字の配列に１足した配列と重複した数字の数が４つある)
      if @suits.uniq.count == 1 && ((numbers.map{|x|x+1} & numbers).count == 4 || numbers == [1, 10, 11, 12, 13])
        @yaku = "ストレートフラッシュ"

        #スートの種類が１つ、かつ、数字が連続していない
      elsif  @suits.uniq.count == 1 && ((numbers.map{|x|x+1} & numbers).count != 4 && numbers != [1, 10, 11, 12, 13])
        @yaku = "フラッシュ"

        #スートの種類が１つではない、かつ、数字が連続している
      elsif  @suits.uniq.count != 1 && ((numbers.map{|x|x+1} & numbers).count == 4 || numbers == [1, 10, 11, 12, 13])
        @yaku = "ストレート"

        #スートの種類が１つでない、かつ、数字が連続していない
      else
        #同じ数字の枚数が４枚
        if duplication == [1,4]
          @yaku = "フォーカード"

          #同じ数字の枚数が３枚
        elsif duplication == [1,1,3]
          @yaku = "スリーカード"

          #同じ数字の枚数が２枚と３枚が１組ずつ
        elsif duplication == [2,3]
          @yaku = "フルハウス"

          #同じ数字の枚数が２枚*２組
        elsif duplication == [1,2,2]
          @yaku = "ツーペア"

          #同じ数字の枚数が２枚*１組
        elsif duplication == [1,1,1,2]
          @yaku = "ワンペア"

          #それ以外
        else
          @yaku = "ハイカード"
        end



      end



  end



  private

  def flush?

  end

  def straight?

  end
end
