require 'minitest/autorun'
require 'minitest/reporters'
require './wheel_gear'

class GearTest < MiniTest::Test

  # Gearの中でWheelをnewしなくなったので、渡す必要がある
  # 依存がなくなり、テスト速度も上がった
  def test_calculatels_geqr_inches
    gear = Gear.new(
        chainring: 52,
        cog:       11,
        wheel: Wheel.new(26, 1.5))

    assert_in_delta(137.1,
                   gear.gear_inches,
                   0.01)
  end
end
