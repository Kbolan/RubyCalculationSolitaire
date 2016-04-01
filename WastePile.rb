require "rubygame"
require "rubygems"
require "./Pile.rb"

class WastePile < Pile
  def initialize x, y
    @x, @y = x, y
    #size of cards + 4 pixels
    cardSize = Array.new [76, 100]
    @surface = Rubygame::Surface.new cardSize, 0, [Rubygame::HWSURFACE, Rubygame::DOUBLEBUF]
    @surface.fill [10,90,10]
    @xw = surface.width
    @yw = surface.height
    #puts @xw.to_s << "   " << @yw.to_s
    @cards = Array.new
    @pileType = "WastePile"
  end
  def intersects? x, y
    if x > @x and x < @x + @xw and y > @y and y < @y + @yw
      return true
    else
      return false
    end
  end
  #when we push, we have to modify the cards location according to offsets
  def push card
    if self.validate card
      #move the card to the pile with an offset
      #also, we should grow the height of the pile
      offset = 15
      card.move @x + 2, (@cards.size * offset) + @y + 2
      @yw += offset
      @cards.push card
      return true
    else
      return false
    end
  end
  def peek
    return @cards.last
  end
  def draw screen
    @surface.blit screen, [@x, @y]
    @cards.each do |card|
      card.draw screen
    end
  end
end