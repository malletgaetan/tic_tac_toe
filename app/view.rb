class View
  def display(state, c_choice, h_choice)
    char_hash = {
      '-1' => h_choice,
      '1' => c_choice,
      '0' => ' '
    }
    puts '-' * 30
    state.each do |row|
      row.each do |cell|
        print " #{char_hash[cell.to_s]} |"
      end
      print "\n"
    end
  end

  def ask_user_for_move
    puts ">x?"
    x = gets.chomp.to_i
    puts ">y?"
    y = gets.chomp.to_i
    return [y, x]
  end
end
