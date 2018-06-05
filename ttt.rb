@game_end = true

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

def turn_X
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

  # while true
  #
  # end
end

def init
  welcome
  board
  while @game_end
    draw_board
    turn_X
  end
end

def welcome
  puts "Welcome to TTT game"
end

init
