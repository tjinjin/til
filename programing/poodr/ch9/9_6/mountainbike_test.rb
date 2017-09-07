require_relative 'test_helper'

class MountainBikeTest < Test::Unit::TestCase
  include BicycleInterfaceTest
  include BicycleSubclassTest

  def setup
    @bike = @object = MountainBike.new()
  end
end
