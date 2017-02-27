require_relative '../class/board_class.rb'

class TestBoard < Minitest::Test
  def setup
    planche_base="
  1 7 3   2 9 4   6 8 5
  2 4 6   5 8 3   1 7 9
  5 8 9   6 7 1   3 4 2

  3 5 4   7 6 8   2 9 1
  7 6 2   9 1 5   8 3 4
  9 1 8   4 3 2   7 5 6

  4 3 5   8 2 6   9 1 7
  6 9 1   3 5 7   4 2 8
  8 2 7   1 4 9   5 6 3
    "

    @board = Board.creer(planche_base.delete("\s|\n")
      .split("").reverse.map(&:to_i))

    @board2 = Board.creer(planche_base.delete("\s|\n")
      .split("").reverse.map(&:to_i))

    planche = "
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
    @boardVide = Board.creer(planche.delete("\s|\n")
      .split("").reverse.map(&:to_i))
  end

  def test_cell_at
    assert_equal 1, @board.cellAt(0,0).value
  end

  def test_excluded
    assert_equal [4,7,9,6,8].sort, @boardVide.excluded(@boardVide.cellAt(0,0)).sort
  end

  def test_posibles
    assert_equal [1,2,3,5].sort, @boardVide.possibles(@boardVide.cellAt(0,0)).sort
  end

  def test_usedCells
    assert_equal 81, @board.usedCells().length
  end

  def test_unusedCells
    assert_equal 58, @boardVide.unusedCells().length
  end

  def test_comparable_copie
    assert_equal true, @board==@board2
    assert_equal true, @board!=@boardVide

    board_copie = @board.copie

    assert_equal true, @board==board_copie

    board_copie.cellAt(1,1).value = 9

    assert_equal false, @board==board_copie

  end

  def test_valide
    assert_equal true, @board.valid?

    board_copie = @board.copie
    board_copie.cellAt(1,1).value = -1
    assert_equal false, board_copie.valid?

    board_copie.cellAt(1,1).value = 9
    assert_equal false, board_copie.valid?

  end

  def test_complete
    assert_equal true, @board.complete?
  end

  def test_swapStack
    planche_base="
  2 9 4   1 7 3   6 8 5
  5 8 3   2 4 6   1 7 9
  6 7 1   5 8 9   3 4 2

  7 6 8   3 5 4   2 9 1
  9 1 5   7 6 2   8 3 4
  4 3 2   9 1 8   7 5 6

  8 2 6   4 3 5   9 1 7
  3 5 7   6 9 1   4 2 8
  1 4 9   8 2 7   5 6 3
    "

    board_result = Board.creer(planche_base.delete("\s|\n")
      .split("").reverse.map(&:to_i))

    board_result.swapStack(0,1)

    assert_equal true, @board==board_result

  end

  def test_swapBand
    planche_base="
  3 5 4   7 6 8   2 9 1
  7 6 2   9 1 5   8 3 4
  9 1 8   4 3 2   7 5 6

  1 7 3   2 9 4   6 8 5
  2 4 6   5 8 3   1 7 9
  5 8 9   6 7 1   3 4 2

  4 3 5   8 2 6   9 1 7
  6 9 1   3 5 7   4 2 8
  8 2 7   1 4 9   5 6 3
    "

    board_result = Board.creer(planche_base.delete("\s|\n")
      .split("").reverse.map(&:to_i))

    board_result.swapBand(0,1)

    assert_equal true, @board==board_result

  end

  def test_tos
    assert_equal "_____4________3__9_8___1__2__4_68___7_____8__9__4___56_3__2____69__5__2___71_____", @boardVide.to_s.delete("\s|\n")
  end

  def test_serialized

    testFile = " toto.yml"
    @board.serialized(testFile)

    boardSortie = Board.unserialized(testFile)

    assert_equal true, @board==boardSortie
    File.delete(testFile)

  end

end
