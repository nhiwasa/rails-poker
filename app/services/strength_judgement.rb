class StrengthJudgement
  attr_reader :scores
  attr_reader :best

  def initialize(x)
    @yaku = x
  end

  def evaluate
    @scores = []
    @yaku.each do |a|
      if  a == "ストレートフラッシュ"
        @scores << 9
      elsif  a == "フォーカード"
        @scores << 8
      elsif a == "フルハウス"
        @scores << 7
      elsif a == "フラッシュ"
        @scores << 6
      elsif a == "ストレート"
        @scores << 5
      elsif a == "スリーカード"
        @scores << 4
      elsif a == "ツーペア"
        @scores << 3
      elsif a == "ワンペア"
        @scores << 2
      elsif a == "ハイカード"
        @scores << 1
      end


    end

    @best = []

    scores.each do |score|
      if score == scores.max
        @best << "true"
      else
        @best << "false"
      end
    end
  end


end