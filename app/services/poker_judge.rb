class Hnad_evaluation

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
        @result = "スリーカード"

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
end


