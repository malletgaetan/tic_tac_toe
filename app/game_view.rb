class GameView
  def displayGame(move_list)
    puts "-" * 40
    puts " #{move_list[0][0]} | #{move_list[0][1]} | #{move_list[0][2]}"
    puts "-----------"
    puts " #{move_list[1][0]} | #{move_list[1][1]} | #{move_list[1][2]}"
    puts "-----------"
    puts " #{move_list[2][0]} | #{move_list[2][1]} | #{move_list[2][2]}"
  end

  def ask_user_for_move
    puts "X coordinate for your play>(0<=x<=2)"
    x = gets.chomp.to_i
    puts "Y coordinate for your play>(0<=y<=2)"
    y = gets.chomp.to_i
    return [x,y]
  end
end
