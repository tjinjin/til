require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'roadbike'
require_relative 'bicycle_interface_test'

class RoadBikeTest < MiniTest::Test
  include BicycleInterfaceTest

  def setup
    @bike = @object = RoadBike.new()
  end
end
