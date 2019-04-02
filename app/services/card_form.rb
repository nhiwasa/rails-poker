class CardForm

  attr_reader :role
  attr_reader :errors

  def initialize(hand)
    @hands = hand
  end

  def valid?

    @errors = []

    #５つ以外の手が入力された場合
    if @hands.count != 5
      @errors << "5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）"
      return false
    #カードが重複している
    elsif @hands.uniq.count != 5
      @errors << "カードが重複しています。"
      return false
    end

    @hands.each_with_index do |hand, i|
      number = hand[1..2].to_i
      if [*(1..13)].include?(number) == false
        @errors << "#{i+1}番目のカード指定文字が不正です。(#{hand})"
      elsif ["S", "D", "C", "H"].include?(hand[0]) == false
        @errors << "#{i+1}番目のカード指定文字が不正です。(#{hand})"
      end

    end

    if @errors.present?
      @errors << "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
      return false
    end

    return true


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
        @role = "ストレートフラッシュ"

        #スートの種類が１つ、かつ、数字が連続していない
      elsif  @suits.uniq.count == 1 && ((numbers.map{|x|x+1} & numbers).count != 4 && numbers != [1, 10, 11, 12, 13])
        @role = "フラッシュ"

        #スートの種類が１つではない、かつ、数字が連続している
      elsif  @suits.uniq.count != 1 && ((numbers.map{|x|x+1} & numbers).count == 4 || numbers == [1, 10, 11, 12, 13])
        @role = "ストレート"

        #スートの種類が１つでない、かつ、数字が連続していない
      else
        #同じ数字の枚数が４枚
        if duplication == [1,4]
          @role = "フォーカード"

          #同じ数字の枚数が３枚
        elsif duplication == [1,1,3]
          @role = "スリーカード"

          #同じ数字の枚数が２枚と３枚が１組ずつ
        elsif duplication == [2,3]
          @role = "フルハウス"

          #同じ数字の枚数が２枚*２組
        elsif duplication == [1,2,2]
          @role = "ツーペア"

          #同じ数字の枚数が２枚*１組
        elsif duplication == [1,1,1,2]
          @role = "ワンペア"

          #それ以外
        else
          @role = "ハイカード"
        end



      end



  end




end
