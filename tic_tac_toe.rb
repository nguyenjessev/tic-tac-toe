# frozen_string_literal: true

require 'pry'

module TicTacToe
  # This class represents the game instance
  class Game
    attr_accessor :current_player
    attr_reader :board, :player1, :player2

    def initialize
      @board = Board.new
      @player1 = Player.new('X')
      @player2 = Player.new('O')
      @current_player = player1
    end

    def start_game
      puts "\nA new game has started!"

      loop do
        board.show
        play_turn(current_player)
        break unless game_over.nil?

        switch_turns
      end

      board.show
      print_endgame_message
    end

    private

    def print_endgame_message
      if game_over == :draw
        puts 'The game is a draw!'
      else
        puts "Congratulations! Player #{current_player.team} wins the game!"
      end
    end

    def game_over
      return current_player if board.winning_positions.any? do |line|
        line.all? { |cell| cell.status == current_player.team }
      end
      return :draw if board.all_full?
    end

    def switch_turns
      self.current_player = if current_player == player1
                              player2
                            else
                              player1
                            end
      current_player
    end

    def play_turn(player)
      puts "Player #{player.team}, it is now your turn."
      while true
        puts 'Enter a number to take the corresponding cell in the game board:'
        choice = read_player_input
        break if board.place_marker(choice, player.team)

        board.show
        puts 'Invalid input. Please try again.'
      end
      board.place_marker(choice, player.team)
    end

    def read_player_input
      gets.chomp.to_i
    end
  end

  # This class represents a player
  class Player
    attr_reader :team
    def initialize(team)
      @team = team
    end
  end

  # This class represents the game board itself
  class Board
    attr_reader :board_size, :board

    def initialize(board_size = 3)
      @board_size = board_size
      build_board
    end

    def all_full?
      board.all? do |row|
        row.none?(&:empty?)
      end
    end

    def show
      puts
      board.each_with_index do |row, row_index|
        row.each_with_index do |cell, column_index|
          print cell.status == ' ' ? (column_index + 1) + (3 * row_index) : cell
          print ' | ' unless column_index == 2
        end

        puts "\n- - - - -" unless row_index == 2
      end

      puts
      puts
    end

    def place_marker(index, team)
      return false unless index.between?(1, 9)

      cell = get_cell(index)

      return false unless cell.empty?

      cell.status = team
      true
    end

    def winning_positions
      board + board.transpose + diagonals
    end

    private

    def get_cell(index)
      column_index = (index - 1) % 3
      row_index = (index - 1) / 3
      board[row_index][column_index]
    end

    def diagonals
      [[get_cell(1), get_cell(5), get_cell(9)],
       [get_cell(3), get_cell(5), get_cell(7)]]
    end

    def build_board
      @board = Array.new(board_size) { Array.new(board_size) { Cell.new } }
    end
  end

  # This class represents a cell on the game board
  class Cell
    attr_accessor :status

    def initialize(status = ' ')
      @status = status
    end

    def to_s
      status
    end

    def empty?
      status == ' '
    end
  end
end

game = TicTacToe::Game.new
game.start_game
