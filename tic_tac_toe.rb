# frozen_string_literal: true

module TicTacToe
  # This class represents te game instance
  class Game
    attr_reader :board

    def initialize
      @board = Board.new
    end

    private

    def start_game
      game_over = false

      puts 'A new game has started!'

      until game_over
        board.display
      end
    end
  end

  # This class represents the game board itself
  class Board
    attr_reader :board_size, :board

    def initialize(board_size = 3)
      @board_size = board_size
      build_board
    end

    def to_s
      board.each_with_index do |row, index|
        puts "#{row[0]} | #{row[1]} | #{row[2]}"
        puts '- - - - -' unless index == 2
      end
    end

    private

    def build_board
      @board = Array.new(board_size, Array.new(board_size, Cell.new))
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
