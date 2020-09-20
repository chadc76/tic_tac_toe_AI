require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    possible_moves = node.children.shuffle
    possible_moves.each do |child|
      return child.prev_move_pos if child.winning_node?(mark)
    end
    possible_moves.each do |child|
      return child.prev_move_pos if !child.losing_node?(mark)
    end
    Raise "There are no non-losing nodes!"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
