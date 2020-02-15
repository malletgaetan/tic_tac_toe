class Router
  def initialize(controller)
    @controller = controller
    @running = true
  end

  def run
    count = [1,2].sample
    puts count.odd? ? "player start" : "bot start"
    until @controller.winner
      @controller.player_turn('O', 'X') if count.odd?
      @controller.bot_turn('O', 'X') if count.even?
      count += 1
    end
    puts "#{@controller.winner} won the game!"
  end
end
