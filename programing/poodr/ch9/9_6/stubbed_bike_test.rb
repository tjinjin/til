require_relative 'test_helper'

# このテストが期待するインターフェースを、
# テストダブルが守ることを証明する

class StubbedBikeTest < Test::Unit::TestCase
  include BicycleSubclassTest

  def setup
    @object = StubbedBike.new
  end
end
