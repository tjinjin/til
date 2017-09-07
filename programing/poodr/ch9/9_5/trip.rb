# 最初の状態
#
class Trip
  attr_reader :bicycles, :customers, :vehicle

  # prepare_bicycleを理解しないンスタンスが増える
  def prepare(prepares)
    prepares.each {|preparer|
      case preparer
      when Mechanic
        preparer.prepare_bicycles(bicycles)
      when TripCoordinator
        preparer.buy_food(customers)
      when Driver
        preparer.gas_up(vehicle)
        preparer.fill_water_tank(vehicle)
      end
    }
  end
end

class Mechanic
  def prepare_bicycles(bicycles)
    bicycles.each {|bicycles| prepare_bicycle(bicycle)}
  end

  def prepare_bicycle(bicycle)
    puts "prepare_bicycle #{bicycle}"
  end
end

# TripCoordinatorとDriverを追加
class TripCoordinator
  def buy_food(customers)

  end
end

class Driver
  def gas_up(vehicle)

  end

  def fill_water_tank(vehicle)

  end
end
