class Hnad_evaluation

  #スートの種類が一つ、かつ、数字が連続している(数字の配列に１足した配列と重複した数字の数が４つある)
  if suits.uniq.count == 1 && ((numbers.map{|x|x+1} & numbers).count == 4 || numbers == [1, 10, 11, 12, 13])
    p "ストレートフラッシュ"

    #スートの種類が１つ、かつ、数字が連続していない
  elsif  suits.uniq.count == 1 && ((numbers.map{|x|x+1} & numbers).count != 4 && numbers != [1, 10, 11, 12, 13])
    p "フラッシュ"

    #スートの種類が１つではない、かつ、数字が連続している
  elsif  suits.uniq.count != 1 && ((numbers.map{|x|x+1} & numbers).count == 4 || numbers == [1, 10, 11, 12, 13])
    p "ストレート"

    #スートの種類が１つでない、かつ、数字が連続していない
  else
    #同じ数字の枚数が４枚
    if duplication == [1,4]
      p "フォーカード"

      #同じ数字の枚数が３枚
    elsif duplication == [1,1,3]
      p "スリーカード"

      #同じ数字の枚数が２枚と３枚が１組ずつ
    elsif duplication == [2,3]
      p "フルハウス"

      #同じ数字の枚数が２枚*２組
    elsif duplication == [1,2,2]
      p "ツーペア"

      #同じ数字の枚数が２枚*１組
    elsif duplication == [1,1,1,2]
      p "ワンペア"

      #それ以外
    else
      p "ハイカード"
    end
  end
end


