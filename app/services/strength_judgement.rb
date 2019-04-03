class StrengthJudgement
  attr_reader :best

  def initialize(roles)
    @roles = roles

  end

  def strength_judgement
    scores = []
    @roles.each do |role|
      if  role == "ストレートフラッシュ"
        scores << 9
      elsif  role == "フォーカード"
        scores << 8
      elsif role == "フルハウス"
        scores << 7
      elsif role == "フラッシュ"
        scores << 6
      elsif role == "ストレート"
        scores << 5
      elsif role == "スリーカード"
        scores << 4
      elsif role == "ツーペア"
        scores << 3
      elsif role == "ワンペア"
        scores << 2
      elsif role == "ハイカード"
        scores << 1
      else
        scores << 0
      end


    end

    @best = []

    scores.each do |score|
      if score == scores.max
        @best << {best: true}
      else
        @best << {best: false}
      end

    end
  end

end