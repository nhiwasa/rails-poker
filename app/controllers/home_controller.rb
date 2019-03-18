class HomeController < ApplicationController
  def top
  end

require_relative "../services/card_form"

  def judge
    hand = params[:cards].split
    @card = CardForm.new(hand)
    if @card.valid?
      @card.check
    end

  end


end


  #object = CardForm.new(params)
  #if object.valid?
    #object.judge
    #redirect_to hoge
  #end
  #render error

