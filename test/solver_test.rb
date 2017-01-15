require_relative '../class/solver_class.rb'

class TestSolver < Minitest::Test
  def setup
    planche_base = "
  _ _ _   _ _ 4   _ _ _
  _ _ _   _ _ 3   _ _ 9
  _ 8 _   _ _ 1   _ _ 2

  _ _ 4   _ 6 8   _ _ _
  7 _ _   _ _ _   8 _ _
  9 _ _   4 _ _   _ 5 6

  _ 3 _   _ 2 _   _ _ _
  6 9 _   _ 5 _   _ 2 _
  _ _ 7   1 _ _   _ _ _
    ".tr("_", "0")
    test = Board.creer(planche_base.delete("\s|\n")
      .split("").reverse.map(&:to_i))

    @solver = Solver.creer(test)

    planche_base_notSolvable= "
  _ _ _   _ _ _   _ _ _
  _ _ _   _ _ 3   _ _ 9
  _ 8 _   _ _ 1   _ _ 2

  _ _ 4   _ 6 8   _ _ _
  7 _ _   _ _ _   8 _ _
  9 _ _   4 _ _   _ 5 6

  _ 3 _   _ 2 _   _ _ _
  6 9 _   _ 5 _   _ 2 _
  _ _ 7   1 _ _   _ _ _
    ".tr("_", "0")
    test = Board.creer(planche_base_notSolvable.delete("\s|\n")
      .split("").reverse.map(&:to_i))

    @solverNotSolvable = Solver.creer(test)
  end

  def test_solver
    # Solution Logique
    @solver.solveLogic
    @solverNotSolvable.solveLogic
    assert_equal true, @solver.board.complete?
    assert_equal false, @solverNotSolvable.board.complete?
    # solution backtracking
    # print "Le Solver trouve une solution à une planche ambigue(long)\n"
    # @solverNotSolvable.solve
    # assert_equal true, @solverNotSolvable.board.complete?
  end

end
