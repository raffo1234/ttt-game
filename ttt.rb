def board
  @positions = {
    'a1' => ' ',
    'a2' => ' ',
    'a3' => ' ',
    'b1' => ' ',
    'b2' => ' ',
    'b3' => ' ',
    'c1' => ' ',
    'c2' => ' ',
    'c3' => ' '
  }
end

def wins
  [
    [@positions['a1'], @positions['a2'], @positions['a3']],
    [@positions['b1'], @positions['b2'], @positions['b3']],
    [@positions['c1'], @positions['c2'], @positions['c3']],
    [@positions['a1'], @positions['b1'], @positions['c1']],
    [@positions['a2'], @positions['b2'], @positions['c2']],
    [@positions['a3'], @positions['b3'], @positions['c3']],
    [@positions['a1'], @positions['b2'], @positions['c3']],
    [@positions['a3'], @positions['b2'], @positions['c1']]
  ]
end

def draw_board
  puts
  puts "   1   2   3"
  puts "a  #{@positions['a1']} | #{@positions['a2']} | #{@positions['a3']} "
  puts "  ---|---|---"
  puts "b  #{@positions['b1']} | #{@positions['b2']} | #{@positions['b3']} "
  puts "  ---|---|---"
  puts "c  #{@positions['c1']} | #{@positions['c2']} | #{@positions['c3']} "
  puts
end

def check_new_choice(choice)
  if choice == 'q'
    puts 'Bye!'
    exit
  end
end

def same_values(values)
  values.uniq.length == 1
end

def available_squares
  @positions.has_value?(' ')
end

def check_for_winner
  wins.each do |win|
    if same_values(win) && any_empty_values(win)
      puts 'Win!!!'
      exit
    end
    if same_values(win) && !available_squares
      puts 'Win!!!'
      exit
    end
    if !same_values(win) && !available_squares
      puts 'Draw!!!'
      exit
    end
  end
end

def any_empty_values(arr)
  (arr & ['X', 'O']).any?
end

def turn_X
  check_for_winner
  puts 'Turn (X), please choose a square:'
  new_choice = gets.chomp.downcase
  check_new_choice(new_choice)
  @positions.each do |choice, square|
    if new_choice == choice
      if square == ' '
        @positions[choice] = 'X'
        draw_board
        turn_O
      else
        draw_board
        turn_X
      end
    end
  end
end

def turn_O
  check_for_winner
  puts 'Turn (O), please choose a square:'
  new_choice = gets.chomp.downcase
  check_new_choice(new_choice)
  @positions.each do |choice, square|
    if new_choice == choice
      if square == ' '
        @positions[choice] = 'O'
        draw_board
        turn_X
      else
        draw_board
        turn_O
      end
    end
  end
end

def init
  welcome
  board
  while true
    check_for_winner
    draw_board
    turn_X
  end
end

def welcome
  puts "Welcome to TTT game"
end

init
