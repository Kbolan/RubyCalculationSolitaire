require "rubygame"
require "rubygems"
require "./Deck.rb"
require "./Foundation.rb"
require "./WastePile.rb"
require "./Hand.rb"
Rubygame::TTF.setup

class Board
  attr_accessor :screen, :events, :deck
  def initialize
    
  
    
    @screen = Rubygame::Screen.new [800, 500], 0, [Rubygame::HWSURFACE, Rubygame::DOUBLEBUF]
    @screen.title = "Calculation Solitaire"
    @events = Rubygame::EventQueue.new
    @screen.fill [20, 100, 20]
    @screen.update
    #add deck
    firstRowY = 10
    @deck = Deck.new 5, firstRowY
    #add foundations
    foundationsXOffset = 200
    offset = 8
    @foundation1 = Foundation.new foundationsXOffset, firstRowY, 1
    @foundation2 = Foundation.new @foundation1.x + @foundation1.xw + offset, firstRowY, 2
    @foundation3 = Foundation.new @foundation2.x + @foundation2.xw + offset, firstRowY, 3
    @foundation4 = Foundation.new @foundation3.x + @foundation3.xw + offset, firstRowY, 4
    #add cards to foundations
    card = @deck.findAndRemoveCard 1
    @foundation1.push card
    card = @deck.findAndRemoveCard 2
    @foundation2.push card
    card = @deck.findAndRemoveCard 3
    @foundation3.push card
    card = @deck.findAndRemoveCard 4
    @foundation4.push card
    #add waste piles
    secondRowY = 200
    @wastePile1 = WastePile.new foundationsXOffset, secondRowY
    @wastePile2 = WastePile.new @wastePile1.x + @wastePile1.xw + offset, secondRowY
    @wastePile3 = WastePile.new @wastePile2.x + @wastePile2.xw + offset, secondRowY
    @wastePile4 = WastePile.new @wastePile3.x + @wastePile3.xw + offset, secondRowY
    @hand = Hand.new
    
  end
  def event_loop
    running = true
    cardIsIn = nil
    while running
      @events.each do |event|
        puts event
        #add events here
        case event
        when Rubygame::QuitEvent
          running = false
        when Rubygame::MouseDownEvent
          #check if decks draw space or waste piles were clicked
          x = event.pos[0]
          y = event.pos[1]
          if @deck.peek != nil and !@deck.empty and @deck.peek.click? x, y
            @hand.addCard @deck
          elsif @deck.peek != nil and @deck.empty and @deck.click? x, y
          end
          if @wastePile1.peek != nil and @wastePile1.peek.click? x, y
            @hand.addCard @wastePile1
          end
           if @wastePile2.peek != nil and @wastePile2.peek.click? x, y
             @hand.addCard @wastePile2
          end
           if @wastePile3.peek != nil and @wastePile3.peek.click? x, y
            @hand.addCard @wastePile3
          end
           if @wastePile4.peek != nil and @wastePile4.peek.click? x, y
            @hand.addCard @wastePile4
          end
        when Rubygame::MouseUpEvent
          #ok, here we do a lot of crap
          x = event.pos[0]
          y = event.pos[1]
          if @foundation1.intersects? x, y
            @hand.placeCard @foundation1
          end
          if @foundation2.intersects? x, y
            @hand.placeCard @foundation2
          end
          if @foundation3.intersects? x, y
            @hand.placeCard @foundation3
          end
          if @foundation4.intersects? x, y
            @hand.placeCard @foundation4
          end
          #We check if it intersects with a waste pile AND that it isn't from a waste pile
          if @wastePile1.intersects? x, y and @hand.fromPile != nil and @hand.fromPile.pileType != "WastePile"
            @hand.placeCard @wastePile1
          end
          if @wastePile2.intersects? x, y and @hand.fromPile != nil and @hand.fromPile.pileType != "WastePile"
            @hand.placeCard @wastePile2
          end
          if @wastePile3.intersects? x, y and @hand.fromPile != nil and @hand.fromPile.pileType != "WastePile"
            @hand.placeCard @wastePile3
          end
          if @wastePile4.intersects? x, y and @hand.fromPile != nil and @hand.fromPile.pileType != "WastePile"
            @hand.placeCard @wastePile4
          end
          @hand.putCardBack
        when Rubygame::MouseMotionEvent
          #try to move from decks draw space, and the waste piles
          x = event.rel[0]
          y = event.rel[1]
          if !@hand.empty
            @hand.card.tryToMove x, y
          end
        end
      end
      @foundation1.draw @screen
      @foundation2.draw @screen
      @foundation3.draw @screen
      @foundation4.draw @screen
      @wastePile1.draw @screen
      @wastePile2.draw @screen
      @wastePile3.draw @screen
      @wastePile4.draw @screen
      @deck.draw @screen
      @hand.draw @screen
      @screen.update
      @screen.fill [20,100,20]
    end
  end
end

board = Board.new
    @screen = Rubygame::Screen.open [ 640, 480]
    @screen.title = "Welcome To Calculation Solitaire!"    
    @screen.fill [20, 100, 20]  
    @screen.update
    @event_queue = Rubygame::EventQueue.new 
    @event_queue.enable_new_style_events 
    
    
    while event = @event_queue.wait 
      p event    
      if event.is_a? Rubygame::Events::MousePressed
        break
      end
    
    end 




board.event_loop