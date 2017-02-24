require_relative '../class/generator_class.rb'

class TestGenerator < Minitest::Test
  def setup
    @gen = Generator.new
  end

  def test_generator
    assert_equal true, @gen.board.complete?
  end

  def test_randomize
    board_copie = @gen.board.copie
    @gen.randomize
    assert_equal false, board_copie==@gen.board
  end

  def test_reduce
    print "Creation d'une planche reduite\n"
    Generator.reduce(@gen.board,:hard)
    assert_equal false, @gen.board.unusedCells == 0
    assert_equal @gen.board.usedCells.first.freeze?, true
  end

end
