require_relative 'game_controller.rb'

class Router
  def initialize(controller)
    @controller = controller
    @running = true
  end

  def run
    count = [1,2].sample
    puts count.odd? ? "player start" : "bot start"
    while @running
      @controller.player_turn if count.odd?
      @controller.bot_turn if count.even?
      unless @controller.game_state
        puts "-" * 30
        puts "#{@controller.winner} won this game!"
        puts "-" * 30
        @running = false
      end
      count += 1
    end
  end
end
