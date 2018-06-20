@values = %w(X O)

def board
  @positions = {}
  tiles = %i(a1 a2 a3 b1 b2 b3 c1 c2 c3)
  tiles.each { |item| @positions[item] = ' ' }
end

def wins
  [
    %i(a1 a2 a3),
    %i(b1 b2 b3),
    %i(c1 c2 c3),
    %i(a1 b1 c1),
    %i(a2 b2 c2),
    %i(a3 b3 c3),
    %i(a1 b2 c3),
    %i(a3 b2 c1)
  ].map do |list|
    list.map { |item| @positions[item] }
  end
end

def draw_line(list)
  list.map { |item| @positions[item] }.join(' | ')
end

def draw_board
  puts
  puts "   1   2   3"
  puts "a  #{draw_line(%i(a1 a2 a3))} "
  puts "  ---|---|---"
  puts "b  #{draw_line(%i(b1 b2 b3))} "
  puts "  ---|---|---"
  puts "c  #{draw_line(%i(c1 c2 c3))} "
  puts
end

def check_new_choice(choice)
  abort('Bye!') if choice == 'q'
end

def same_values(values)
  values.uniq.size == 1
end

def available_squares
  @positions.has_value?(' ')
end

def check_for_winner
  wins.each do |win|
    abort('Win!!!')  if same_values(win)  && any_empty_values(win)
    abort('Win!!!')  if same_values(win)  && !available_squares
    abort('Draw :/') if !same_values(win) && !available_squares
  end
end

def any_empty_values(list)
  (list & @values).any?
end

def turn(value)
  check_for_winner
  puts "Turn (#{value}), please choose a square:"
  new_choice = gets.chomp.downcase.to_sym
  check_new_choice(new_choice)
  @positions.each do |choice, square|
    next unless new_choice == choice
    if square.strip.empty?
      @positions[choice] = value
      draw_board
      next_value = (@values - [value]).first
      turn(next_value)
    else
      draw_board
      turn(value)
    end
  end
end

def init
  welcome
  board
  while true
    check_for_winner
    draw_board
    turn(@values.first)
  end
end

def welcome
  puts "Welcome to TTT game"
end

init
