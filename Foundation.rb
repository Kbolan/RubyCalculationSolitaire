require "rubygame"
require "rubygems"
require "./Pile.rb"

class Foundation < Pile
  def initialize x, y, multiplier
    @x, @y = x, y
    @multiplier = multiplier
    #size of cards + 4 pixels
    cardSize = Array.new [76, 100]
    @surface = Rubygame::Surface.new cardSize, 0, [Rubygame::HWSURFACE, Rubygame::DOUBLEBUF]
    @surface.fill [10,90,10]
    @xw = surface.width
    @yw = surface.height
    @cards = Array.new
    @pileType = "Foundation"
  end
  #We need to modify validate
  def intersects? x, y
    if x > @x and x < @x + @xw and y > @y and y < @y + @yw
      return true
    else
      return false
    end
  end
  def validate card
    if card.value == ((@cards.size + 1) * @multiplier) % 13
      return true
    else
      return false
    end
  end
  def update
    @cards.last.surface.blit @surface, [2,2]
  end
end