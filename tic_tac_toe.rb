# frozen_string_literal: true

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
        if game_over
          return
        else
          switch_turns
        end
      end
    end

    private

    def switch_turns
      current_player = if current_player == player1
                         player2
                       else
                         player1
                       end

      current_player
    end

    def play_turn(player)
      puts "Player #{player.team}, it is now your turn."
      puts 'Enter a number to take the corresponding cell in the game board:'
      choice = read_player_input
      board.place_marker(choice, player.team)
    end

    def read_player_input
      gets.chomp.to_i
    end

    def check_for_winner(player)
      nil
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

    def place_marker(cell, team)
      column_index = (cell - 1) % 3
      row_index = (cell - 1) / 3

      board[row_index][column_index].status = team
    end

    private

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
  end
end

game = TicTacToe::Game.new
game.start_game
