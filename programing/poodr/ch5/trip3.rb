# 設計が増えたときの例
class Trip
  attr_reader :bicycles, :customers, :vehicle

  # 呼び出しはまとめる
  def prepare(prepares)
    prepares.each {|preparer|
      preparer.prepare_trip(self)
    }
  end
end

# すべての準備者は`prepara_trip`
class Mechanic
  def prepare_trip(trip)
    trip.bicycles.each {|bicycles|
      prepare_bicycle(bicycle)
    }
  end

  def prepare_bicycle(bicycle)
    puts "prepare_bicycle #{bicycle}"
  end
end

# TripCoordinatorとDriverを追加
class TripCoordinator
  def prepare_trip(trip)
    buy_food(trip.customers)
  end

  def buy_food(customers)

  end
end

class Driver
  def prepare_trip(trip)
    vehicle = trip.vehicle
    gas_up(vehicle)
    fill_water_tank(vehicle)
  end

  def gas_up(vehicle)

  end

  def fill_water_tank(vehicle)

  end
end
