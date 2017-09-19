require_relative 'test_helper'

class RoadBikeTest < Test::Unit::TestCase
  include BicycleInterfaceTest
  include BicycleSubclassTest

  def setup
    @bike = @object = RoadBike.new()
  end
end
