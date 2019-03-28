
module API
  module Ver1
    class Judge < Grape::API
      format :json



      # /api/v1/judge/
      post '/judge' do
        hands = params[:cards]
        a = []
        b = []
        hands.each do |hand|
          card = hand.split
          card = CardForm.new(card)
          if card.valid?
            card.check
          end

          a << {card: "#{hand}", hand: "#{card.yaku}" , best: ""}

          b << card.yaku
        end

        scores = []
        b.each do |c|
          if  c == "ストレートフラッシュ"
            scores << 9
          elsif  c == "フォーカード"
            scores << 8
          elsif c == "フルハウス"
            scores << 7
          elsif c == "フラッシュ"
            scores << 6
          elsif c == "ストレート"
            scores << 5
          elsif c == "スリーカード"
            scores << 4
          elsif c == "ツーペア"
            scores << 3
          elsif c == "ワンペア"
            scores << 2
          elsif c == "ハイカード"
            scores << 1
          end


        end

        best = []

        scores.each do |score|
          if score == scores.max
            best << {best: true}
          else
            best << {best: false}
          end

        end

        result = []

        a.zip(best).each do |x, y|
          result << x.update(y)
        end

        reply = [result: result]
















      end

    end
  end
end