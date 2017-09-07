require 'minitest/autorun'
require './wheel_gear'

class WheelTest < MiniTest::Unit::TestCase

  def setup
    @wheel = Wheel.new(26, 1.5)
  end

  def test_calcurates_diameter
    assert_in_delta(29,
                    @wheel.diameter,
                    0.01)
  end
end
