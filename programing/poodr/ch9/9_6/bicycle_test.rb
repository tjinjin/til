require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'bicycle'
require_relative 'bicycle_interface_test'

class BicycleTest < MiniTest::Test
  include BicycleInterfaceTest

  def setup
    @bike = @object = Bicycle.new({tire_size: 0})
  end
end
