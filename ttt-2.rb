#!/usr/bin/env ruby

class Board

  attr_accessor :state

  def initialize
    @state = " " + " " * 9

  end

  def draw
    $stdout.write(" #{@state[1]} | #{@state[2]} | #{@state[3]} \n")
    $stdout.write(" (1) | (2) | (3) \n")
    $stdout.write("-----------\n")
    $stdout.write(" #{@state[4]} | #{@state[5]} | #{@state[6]} \n")
    $stdout.write("-----------\n")
    $stdout.write(" #{@state[7]} | #{@state[8]} | #{@state[7]} \n")
  end

  def valid_move?(move)
    valid_moves.include?(move)
  end

  def valid_moves
    [1..9].select { |ix|
      " " == @state[ix]
    }
  end

  def has_winner
    false
  end

  def do(move, player)
    @state[move] = player
  end
end

class Game

  attr_accessor :active_player
  attr_accessor :board

  def initialize
    @active_player = 'X'
    @board = Board.new
  end

  def next_active_player
    if active_player == 'X'
      @active_player = 'O'
    else
      @active_player = 'X'
    end
  end

  def at_game_end?
    board.valid_moves.empty? or board.has_winner
  end

  def ask_for_play(player)
    puts "Whats your play #{player}?"
    gets.strip.to_sym
  end

  def begin
    while !at_game_end?
      board.draw
      move = ask_for_play(active_player)
      if board.valid_move?(move)
        board.do(move, active_player)
        next_active_player
      else
        $stdout.write("Invalid Move!\n")
        next
      end
    end
  end
end

Game.new.begin
