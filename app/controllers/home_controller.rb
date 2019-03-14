class HomeController < ApplicationController
  def top
  end

  def judge
    p "パラメータ"
    p params[:cards]

    hand = params[:cards].split



    suits = []
    numbers = []

    hand.each do |a|
      suits.push a[0]
      numbers.push a[1..2]
    end


    numbers = numbers.map(&:to_i).sort






  end
end
