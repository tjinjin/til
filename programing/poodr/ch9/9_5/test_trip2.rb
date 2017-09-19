require 'minitest/autorun'
require 'minitest/reporters'
require './trip2'


module PreparerInterfaceTest
  def test_implements_the_preparer_interface
    # 与えられたオブジェクトが与えられたメソッドを持つ場合、検査にパスしたことになる
    assert_respond_to(@object, :prepare_trip)
  end
end

# すべての受け手がprepare_testを実装しているかのテスト

class MechanicTest < MiniTest::Test
  include PreparerInterfaceTest

  def setup
    # @mechanicと @objectに Mechanicのオブジェクトをいれている
    @mechanic = @object = Mechanic.new
  end
end

class TripCoordinatorTest < MiniTest::Test
  include PreparerInterfaceTest

  def setup
    @trip_coordinator = @object = TripCoordinator.new
  end
end

class DriverTest < MiniTest::Test
  include PreparerInterfaceTest

  def setup
    @driver = @object = Driver.new
  end
end

# prepare_tripが送られていることの証明

class TripTest < MiniTest::Test
  def test_requests_trip_preparation
    @preparer = Minitest::Mock.new
    @trip = Trip.new

    # メソッド名、返り値、引数を指定する
    @preparer.expect(:prepare_trip, nil, [@trip])

    @trip.prepare([@preparer])

    # expectで指定されたオブジェクトが正しく呼び出されたかを検証
    @preparer.verify
  end
end
