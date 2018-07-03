class Board

  attr_accessor :positions
  # getter and setter
  # attr_reader :state
  # attr_writer :state

  def initialize
    @positions = {}
    tiles = %i(a1 a2 a3 b1 b2 b3 c1 c2 c3)
    tiles.each { |item| @positions[item] = ' ' }
  end

  def draw_line(list)
    list.map { |item| @positions[item] }.join(' | ')
  end

  def draw
    $stdout.write("   1   2   3 \n")
    $stdout.write("\n")
    $stdout.write("a  #{draw_line(%i(a1 a2 a3))} \n")
    $stdout.write("  ---|---|---\n")
    $stdout.write("b  #{draw_line(%i(b1 b2 b3))} \n")
    $stdout.write("  ---|---|---\n")
    $stdout.write("c  #{draw_line(%i(c1 c2 c3))} \n")
  end

  def valid_move?(move)
    valid_moves.include?(move)
  end

  def valid_moves
    @positions.select { |ix|
      " " == @positions[ix]
    }
  end

  def combo_wins
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

  def combo_valid?(xs)
    return false if xs.any? { |x| x == " " }
    xs.uniq.size == 1
  end

  def has_winner
    combo_wins.any? { |combo| combo_valid?(combo)}
  end

  def do(move, player)
    @positions[move] = player
  end
end

class Game

  attr_accessor :current_player
  attr_accessor :board

  def initialize
    @current_player = 'X'
    @board = Board.new
  end

  def next_current_player
    @current_player = @current_player == 'X' ? "O" : "X"
  end

  def at_game_end?
    $stdout.write(board.has_winner)
    board.has_winner || board.valid_moves.empty?
  end

  def ask_for_play(player)
    puts "Whats your play #{player}?"
    gets.strip.to_sym
  end

  def begin
    board.draw

    loop do
      move = ask_for_play(@current_player)
      if board.valid_move?(move)
        board.do(move, @current_player)
        board.draw
        if board.has_winner
          puts "Player #{@current_player} won!"
          break
        end
        next_current_player
      else
        puts("Invalid Move!")
      end
    end
  end
end

Game.new.begin
