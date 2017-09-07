require 'minitest/autorun'
require 'minitest/reporters'
require './wheel_gear'

# 'Diameterizable'ロールの担い手を作る
# テストでのみ使われるようなもの
# ダブル≠ モック
class DiameterDouble
  def diameter
    10
  end
end

class GearTest < MiniTest::Test
  def test_calculates_gear_inches
    gear = Gear.new(
            chainring: 52,
            cog: 11,
            wheel: DiameterDouble.new)

    assert_in_delta(47.27,
                    gear.gear_inches,
                    0.01)
  end
end
