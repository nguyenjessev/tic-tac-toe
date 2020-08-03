# frozen_string_literal: true

module TicTacToe
  # This class represents the game board itself
  class Board
    attr_reader :board_size, :board

    def initialize(board_size = 3)
      @board_size = board_size
      build_board
    end

    private

    def build_board
      @board = Array.new(board_size, Array.new(board_size, Cell.new))
    end
  end

  # This class represents a cell on the game board
  class Cell
    def initialize(status = '')
      @status = status
    end
  end
end
