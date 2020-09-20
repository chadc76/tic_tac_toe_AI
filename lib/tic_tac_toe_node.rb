require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return (board.won? && board.winner != evaluator) if board.over?
    if self.next_mover_mark == evaluator
      self.children.all?{ |node| node.losing_node?(evaluator) }
    else
      self.children.any?{ |node| node.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    return (board.won? && board.winner == evaluator) if board.over?
    if self.next_mover_mark == evaluator
      self.children.any?{ |node| node.winning_node?(evaluator) }
    else
      self.children.all?{ |node| node.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    moves = []
    board.rows.each_with_index do |_, row|
      _.each_with_index do |__, col|
        moves << [row, col] if board.empty?([row, col])
      end
    end
    possible_moves = []
    moves.each do |move|
      start_board = board.dup
      r, c = move
      start_board.rows[r][c] = next_mover_mark
      next_move = ((self.next_mover_mark == :x) ? :o : :x)
      possible_moves << TicTacToeNode.new(start_board, next_move, move)
    end
    possible_moves
  end
end
