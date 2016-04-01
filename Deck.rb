require "rubygame"
require "rubygems"
require "./Card.rb"
require "./Pile.rb"

class Deck < Pile
  attr_accessor :empty
  def initialize x, y
    @cards = Array.new
    self.addCards
    @x, @y = x, y
    @surface = Rubygame::Surface.load "./images/faceDownCard.png"
    @xw = @surface.width
    @yw = @surface.height
    @clicked = false
    #initialize the draw space
    #note, we just move the card above it. Its not special
    cardSize = Array.new [76, 100]
    @space = Rubygame::Surface.new cardSize, 0, [Rubygame::HWSURFACE, Rubygame::DOUBLEBUF]
    @space.fill [10, 90, 10]
    @xs, @ys = x + @xw + 8, y
    #draw first card
    @cards.last.move @xs+4/2, @ys+4/2
    @empty = false
  end
  def click? x, y
    if x > @x and x < @x + @xw and y > @y and y < @y + @yw
      @cards.last.move @xs+4/2, @ys+4/2
      puts "Move card!"
      @empty = false
    end
  end
  def pop
    @empty = true
    #return @cards.last
    return @cards.pop
  end
  def push card
    @cards.push card
    if @empty == true
      @empty = false
      @cards.last.move @xs+4/2, @ys+4/2
    end
    
  end
  def findAndRemoveCard value
    @cards.each_index do |i|
      if @cards[i].value == value
        card = @cards[i]
        @cards[i] = nil
        @cards.compact!
        return card
      end
    end
    puts "No card of that value :("
  end
  def addCards
    for i in 1..13
      for j in 1..4
        #figure out the filename
        file = "./images/"
        if i > 1 and i < 11
          file.concat i.to_s
        elsif i == 1
          file.concat "a"
        elsif i == 11
          file.concat "j"
        elsif i == 12
          file.concat "q"
        elsif i == 13
          file.concat "k"
        end
        if j == 1
          file.concat "Clubs"
        elsif j == 2
          file.concat "Diamonds"
        elsif j == 3
          file.concat "Hearts"
        else
          file.concat "Spades"
        end
        file.concat ".png"
        #load the file
        #puts file
        surface = Rubygame::Surface.load file
        card = Card.new 0,0, surface, i, j
        @cards.push card
      end
    end
    #all cards added to deck
    @cards.shuffle!
    #cards shuffled
  end
  def draw screen
    if !@cards.empty?
      @surface.blit screen, [@x, @y]
    end
    @space.blit screen, [@xs, @ys]
    if !@empty
      peek.draw screen
    end
  end
end