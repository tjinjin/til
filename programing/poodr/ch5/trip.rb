class Trip
  attr_reader :bicycles, :customers, :vehicle

  # この 'mechanic' 引数はどんなクラスでも可
  # prepare_bicyclesで使えるオブジェクトを受け取ることが期待されている
  def prepare(mechanic)
    mechanic.prepare_bicycles(bicycles)
  end
end

# *この*クラスのインスタンスを渡すことになったとしても動作する
class Mechanic
  def prepare_bicycles(bicycles)
    bicycles.each {|bicycles| prepare_bicycle(bicycle)}
  end

  def prepare_bicycle(bicycle)
    puts "prepare_bicycle #{bicycle}"
  end
end
