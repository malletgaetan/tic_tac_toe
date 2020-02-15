require_relative 'view.rb'

HUMAN = -1
COMP = +1

class Controller
  attr_reader :game_state, :winner
  def initialize
    @board = [
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0]
    ]
    @view = View.new
    @game_state = true
    @winner = false
  end

  def evaluate(state)
    if wins(state, COMP)
      score = +1
    elsif wins(state, HUMAN)
      score = -1
    else
      score = 0
    end
    return score
  end

  def wins(state, player)
    win_state = [
      [state[0][0], state[0][1], state[0][2]],
      [state[1][0], state[1][1], state[1][2]],
      [state[2][0], state[2][1], state[2][2]],
      [state[0][0], state[1][0], state[2][0]],
      [state[0][1], state[1][1], state[2][1]],
      [state[0][2], state[1][2], state[2][2]],
      [state[0][0], state[1][1], state[2][2]],
      [state[2][0], state[1][1], state[0][2]]
    ]
    if win_state.include?([player, player, player])
      return true
    else
      return false
    end
  end

  def game_over(state)
    if wins(state, COMP)
      return wins(state, COMP)
    end
    if wins(state, HUMAN)
      return wins(state, HUMAN)
    end
  end

  def empty_cells(state)
    cells = []
    (0..2).each do |x|
      (0..2).each do |y|
        cells << [x, y] if state[x][y] == 0
      end
    end
    return cells
  end

  def valid_move(x, y, state)
    return true if empty_cells(state).include?([x, y])
    return false
  end

  def set_move(x, y, player)
    if valid_move(x, y, @board)
      @board[x][y] = player
    end
  end

  def minimax(state, depth, player)
    if player == COMP
      best = [-1, -1, -1.0/0.0]
    else
      best = [-1, -1, 1.0/0.0]
    end

    if depth == 0 or game_over(state)
      score = evaluate(state)
      return [-1, -1, score]
    end

    empty_cells(state).each do |cell|
      x, y = cell[0], cell[1]
      state[x][y] = player
      score = minimax(state, depth - 1, -player)
      state[x][y] = 0
      score[0], score[1] = x, y
      if player == COMP
        best = score if score[2] > best[2]
      else
        best = score if score[2] < best[2]
      end
    end
    return best
  end

  def continue(depth)
    if depth == 0 || game_over(@board)
      if wins(@board, COMP)
        @winner = COMP
        return false
      elsif wins(@board, HUMAN)
        @winner = HUMAN
        return false
      else
        @winner = 'Equality'
        return false
      end
    end
    return true
  end

  def bot_turn(c_choice, h_choice)
    depth = empty_cells(@board).size
    return 0 unless continue(depth)

    @view.display(@board, c_choice, h_choice)

    if depth == 9
      x = [0,1,2].sample
      y = [0,1,2].sample
    else
      move = minimax(@board, depth, COMP)
      x, y = move[0], move[1]
    end
    set_move(x, y, COMP) if valid_move(x, y, @board)
    sleep 1
  end

  def player_turn(c_choice, h_choice)
    depth = empty_cells(@board).size
    return 0 unless continue(depth)

    @view.display(@board, c_choice, h_choice)
    move = @view.ask_user_for_move
    if valid_move(move[0], move[1], @board)
      set_move(move[0], move[1], HUMAN)
    else
      puts "Incorrect input, please retry"
      player_turn(c_choice, h_choice)
    end
    sleep 1
  end
end
