# 継承関係を作る十分な理由が見つかった時
# sizeを動くようにした
class Bicycle
  attr_reader :size # RoadBikeから昇格

  def initialize(args={})
    @size = args[:size] # RoadBikeから昇格
  end
end

class RoadBike < Bicycle
  # sizeは全体のサイズ、tape_colorはハンドルバーのテープカラー
  attr_reader :tape_color

  # initializeがオーバーライドしている
  def initialize(args)
    @tape_color = args[:tape_color]
    super(args) # RoadBikeはsuperを呼び出さないといけない
  end

  # すべての自転車はデフォルト値として
  # 同じタイヤサイズとチェーンサイズを持つ
  def spares
    {
      chain: '10-speed',
      tire_size: '23',
      tape_color: tape_color,
    }
  end


end

class MountainBike < Bicycle
  attr_reader :size, :tape_color, :front_shock, :rear_shock

  def initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]

    super(args)
  end

  def spares
    super.merge(rear_shock: rear_shock)
  end
end

# sizeだけはどちらも動くようになった
#
mountain_bike = MountainBike.new(
  size: 'S',
  front_shock: 'Maintou',
  rear_shock: 'Fox'
)

p mountain_bike.size

road_bike = RoadBike.new(
  size: 'M',
  tape_color: 'red'
)

p road_bike.size
