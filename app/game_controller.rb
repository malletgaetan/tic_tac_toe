require_relative 'game_state.rb'
require_relative 'game_view.rb'

class GameController

  attr_reader :winner, :game_state
  # displayGame([['','',''],['','',''],['','','']])
  def initialize
    @bot_moves = []
    @player_moves = []
    @table = [[0,0,0],[0,0,0],[0,0,0]]
    @view = GameView.new
    @state = GameState.new
    @game_state = true
    @winner = '?'
  end

  def player_turn
    @view.displayGame(@table)
    move = @view.ask_user_for_move
    set_move(move[0], move[-1], -1)
    refresh_state
  end

  def bot_turn
    #THIS IS WHERE MAGIC HAPPEN
    depth = unplayed_cells.size
    if depth == 9
      x = [0,1,2].sample
      y = [0,1,2].sample
    else
      move = minmax(@table ,depth, 1)
      x = move[0]
      y = move[1]
    end
    puts "x=#{x}||y=#{y}"
    set_move(x, y, 1)
    refresh_state
  end

  private

  def refresh_state
    if @state.state?(@table)
      @winner = @state.state?(@table)
      @game_state = false
    end
  end

  def set_move(x, y, player)
    @table[y][x] = player
  end

  def unplayed_cells
    var = []
    (0..2).each do |x|
      (0..2).each do |y|
        var << [x, y] if @table[y][x] == 0
      end
    end
    return var
  end

  def minmax(table ,depth, player)
    best = player == 1 ? [-1, -1, -1.0/0.0] : [-1, -1, 1.0/0.0]

    if depth == 0 || @state.state?(table)
      if @state.state?(table) == 'bot'
        score = 1
      elsif @state.state?(table) == 'human'
        score = -1
      else
        score = 0
      end
      return [-1, -1, score]
    end

    unplayed_cells.each do |cell|
      x = cell[0]
      y = cell[1]
      table[y][x] = player
      score = minmax(table, depth - 1, -player)
      table[y][x] = 0
      score[0] = x
      score[1] = y

      if player = 1
        if score[2] > best[2]
          best = score
        end
      else
        if score[2] < best[2]
          best = score
        end
      end
    end

    return best
  end
end
