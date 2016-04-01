require "rubygame"
require "rubygems"
require "./Card.rb"
require "./Pile.rb"

class Hand
  attr_accessor :card, :fromPile, :empty
  def initialize
    @card = nil
    @fromPile = nil
    @empty = true;
  end
  def addCard pile
    if pile != nil
      if pile.peek != nil
        #puts "A click occured"
        @fromPile = pile
        @card = pile.pop
        @empty = false
      end
    end
  end
  def placeCard pile
    if @card != nil and @fromPile != nil and pile != nil
      if pile.validate @card
        @card.clicked = false;
        pile.push @card
        @fromPile = nil
        @card = nil
        @empty = true
      else
        #card wouldn't go. Put back
        putCardBack
      end
    end
  end
  def putCardBack
    if @fromPile != nil
      @fromPile.push @card
      @empty = true
      @card.clicked = false;
      @card = nil
      @fromPile = nil
    end
  end
  def draw screen
    if @card != nil
      #puts "Draw hand!"
      @card.draw screen
    end
  end
end