require 'minitest/autorun'
require 'minitest/doc_reporter'
require './wheel_gear'

class GearTest < MiniTest::Unit::TestCase

  # Gearの中でWheelをnewしているという依存がある
  # テストの実行速度の低下やWheelの変更でGearが壊れるリスクがある
  def test_calculatels_geqr_inches
    gear = Gear.new(
        chainring: 52,
        cog:       11,
        rim:       26,
        tire:      1.5)

    assert_in_delta(137.1,
                   gear.gear_inches,
                   0.01)
  end
end
