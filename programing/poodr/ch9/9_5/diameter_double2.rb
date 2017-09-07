require 'minitest/autorun'
require 'minitest/reporters'
require './wheel_gear'

class WheelTest < MiniTest::Test

  def setup
    @wheel = Wheel.new(26, 1.5)
  end

  # Diametarizableロールに対するテスト
  # まだこれだけだとツラミがある
  def test_implements_the_diameterizable_interface
    assert_respond_to(@wheel, :width)
  end

  def test_calculates_diameter
    wheel = Wheel.new(26, 1.5)

    assert_in_delta(29,
                    wheel.diameter,
                    0.01)
  end
end
