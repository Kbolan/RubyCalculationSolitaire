require "rubygame"
require "rubygems"

class Card
  attr_accessor :x, :y, :xw, :yw, :surface, :value, :suite, :clicked
    def initialize x, y, surface, value, suite
    @x, @y = x, y
    @value = value
    @suite = suite
    @surface = surface
    @xw = surface.width
    @yw = surface.height
    @clicked = false
  end
  def move x, y
    #puts x
    #puts y
    @x = x
    @y = y
  end
  def tryToMove x, y
    if @clicked
      @x += x
      @y += y
    end
  end
  def click? x, y
    if x > @x and x < @x + @xw and y > @y and y < @y + @yw
      @clicked = true
      return true
    else
      return false
    end
  end
  def release
    if @clicked
      @clicked = false;
    end
  end
  def draw surface
    #puts @x
    #puts @y
    @surface.blit surface, [@x, @y]
  end
end