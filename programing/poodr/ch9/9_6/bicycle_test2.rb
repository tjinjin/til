require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'bicycle'
require_relative 'bicycle_interface_test'

class BicycleTest < MiniTest::Test
  include BicycleInterfaceTest

  def setup
    @bike = @object = Bicycle.new({tire_size: 0})
  end

  # スーパークラスへの制約を明記
  def test_forces_subclasses_to_implement_default_tire_size
    assert_raises(NotImplementedError) {@bike.default_tire_size}
  end
end
