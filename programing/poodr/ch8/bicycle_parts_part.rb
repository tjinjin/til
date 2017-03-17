# Partを追加
class Bicycle
  attr_reader :size, :parts

  def initialize(args={})
    @size  = args[:size]
    @parts = args[:parts]
  end

  def spares
    parts.spares
  end
end

class Parts
  attr_reader :parts

  def initialize(parts)
    @parts = parts
  end

  def spares
    parts.select {|part| part.needs_spare}
  end
end

class Part
  attr_reader :name, :description, :needs_spare

  def initialize(args)
    @name        = args[:name]
    @description = args[:description]
    @needs_spare = args.fetch(:needs_spare, true)
  end
end

# 部品をそれぞれ作る
# Partのロールを担うオブジェクト
p chain =
  Part.new(name: 'chain', description: '10-speed')

p road_tire =
  Part.new(name: 'tire_size', description: '23')

p tape =
  Part.new(name: 'tape_color', description: 'red')

p mountain_tire =
  Part.new(name: 'tire_size', description: '2.1')

p rear_shock =
  Part.new(name: 'rear_shock', description: 'Fox')

p front_shock =
  Part.new(
    name: 'front_shock',
    description: 'Manitou',
    needs_spare: false)

# Partsオブジェクトをひとまとまりにする
p road_bike_parts =
  Parts.new([chain, road_tire, tape])

# Bicycleを作る際にその場でPartsオブジェクトを作る
road_bike =
  Bicycle.new(
    size: 'L',
    parts: Parts.new([chain,
                      road_tire,
                      tape])
)

p road_bike.size
p road_bike.spares

mountain_bike =
  Bicycle.new(
    size: 'L',
    parts: Parts.new([chain,
                      mountain_tire,
                      front_shock,
                      rear_shock])
)

p mountain_bike.size
p mountain_bike.spares
p mountain_bike.parts

# mountain_bike.spares.size -> 3 インスタンスの数 sparesが配列を返している
# mountain_bike.parts.size  -> error partsのインスタンス
# ここに気付くことができるかが鍵？
# どちらも配列のように"見える"。
# これを回避するには？
# 1.Partsにsizeを実装してもいいが、拡張が大変になる
# def size
#   parts.size
# end
# 2.PartsをArrayにする
# class Parts < Array
#   def spares
#     select {|part| part.needs_spare}
#   end
# end
# 一見正しそうに見えるが、spareで問題がでる
# combo_parts =
#   (mountain_bike.parts + road_bike.parts)
# combo_parts.size # -> 7
# combo_parts.spares Error

