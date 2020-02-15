class GameState
  # [y,x]
  def state?(move_list)
    @move_list = move_list
    return who_win?(diagonal?) if diagonal?

    return who_win?(horizontal?) if horizontal?

    return who_win?(vertical?) if vertical?
  end

  private

  def who_win?(integer)
    integer == -1 ? 'player' : 'bot'
  end

  def diagonal?
    return @move_list[0][0] if @move_list[0][0] == @move_list[1][1] && @move_list[1][1] == @move_list[2][2] && @move_list[0][0] != 0
    return @move_list[0][2] if @move_list[0][2] == @move_list[1][1] && @move_list[1][1] == @move_list[2][0] && @move_list[0][2] != 0
    return false
  end

  def horizontal?
    (0..2).each do |index|
      if @move_list[0][index] == @move_list[1][index] && @move_list[1][index] == @move_list[2][index] && @move_list[0][index] != 0
        return @move_list[0][index]
      end
      return false
    end
  end

  def vertical?
    (0..2).each do |index|
      if @move_list[index][0] == @move_list[index][1] && @move_list[index][1] == @move_list[index][2] && @move_list[index][0] != 0
        return @move_list[index][0]
      end
      return false
    end
  end
end
