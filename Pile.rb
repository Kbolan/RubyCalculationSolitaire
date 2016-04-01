require "rubygame"
require "rubygems"

class Pile
  attr_accessor :x, :y, :xw, :yw, :surface, :pileType
  def initialization x, y, surface
    @x, @y = x, y
    @surface = surface
    @surfaceOriginal = surface
    @xw = surface.width
    @yw = surface.height
    @cards = Array.new
  end
  def push card
    if self.validate card
      @cards.push card
      #move the card to the exact location of the pile
      card.move @x, @y
      return true
    else
      return false
    end
  end
  def peek
    return @cards.last
  end
  def pop
    return @cards.pop
  end
  def validate card
    return true
  end
  def intersects? x, y
    return false
  end
  def draw screen
    self.update
    @surface.blit screen, [@x, @y]
  end
  def update
    
  end
end