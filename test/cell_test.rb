require_relative '../class/cell_class.rb'

class TestCell < Minitest::Test
  def setup
    @cell = Cell.creer(1,1,1)
    @cell2 = Cell.creer(1,5,6)
    @cellVide = Cell.creer(0,5,6)
  end

  def test_comparable
    assert_equal true, @cell==@cell2
    assert_equal false, @cell!=@cellVide
  end

  def test_vide
    assert_equal true, @cellVide.vide?
  end

  def test_tos
    assert_equal "Value: 0, Row: 0, Col: 5, Box: 6", @cellVide.to_s
  end

  def test_not_freeze
    assert_equal false, @cell.origin?
  end

  def test_freeze
    @cell.freeze
    assert_equal true, @cell.origin?
  end
end
