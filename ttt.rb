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

def user
  puts 'Please choose a square:'
  new_choice = gets.chomp.downcase
  check_new_choice(new_choice)
  @positions.each do |choice, square|
    if new_choice == choice
      @positions[choice] = 'X'
    end
  end
end

def init
  welcome
  board
  while true
    draw_board
    user
  end
end

def welcome
  puts "Welcome to TTT game"
end

init
