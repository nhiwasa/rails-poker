class HomeController < ApplicationController


  require_relative "../services/card_form"
  def top
  end



  def judge
    @hand = params[:cards]
    hand = @hand.split
    @card = CardForm.new(hand)
    if @card.valid?
      @card.check
    end

    render :action => "judge"



  end


end


  #object = CardForm.new(params)
  #if object.valid?
    #object.judge
    #redirect_to hoge
  #end
  #render error

