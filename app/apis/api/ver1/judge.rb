
module API
  module Ver1
    class Judge < Grape::API
      format :json



      # /api/v1/judge/
      post '/judge' do
        hands = params[:cards]
        result = []
        roles = []
        hands.each do |hand|
          card = hand.split
          card = CardForm.new(card)
          if card.valid?
            card.check
          end

          if card.errors.present?
            result << {card: "#{hand}", msg: "#{card.errors[0]}"}
            roles << card.role
          else
            result << {card: "#{hand}", hand: "#{card.role}" , best: ""}

            roles << card.role
          end


        end

        roles = StrengthJudgement.new(roles)
        roles.strength_judgement

        results = []

        result.zip(roles.best).each do |x, y|
          results << x.update(y)
        end

        reply = [result: results]
















      end

    end
  end
end