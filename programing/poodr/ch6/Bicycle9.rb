# 継承関係を作る十分な理由が見つかった時
# まずサブクラスにすべて移す
# template methodを実装する
# superclassで基本構造を定義し、サブクラス固有の貢献を得るためにメッセージを送るパターン
# 結合度が強いspares
class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(args={})
    @size = args[:size]
    @chain= args[:chain] || default_chain
    @tire_size= args[:tire_size] || default_tire_size
  end

  def spares
    {
      tire_size: tire_size,
      chain: chain
    }
  end

  def default_chain # 共通の初期値
    '10-speed'
  end

  # 実装が必要なことを知らせる
  def default_tire_size
    raise NotImplementedError, "This #{self.class} cannot respond to:"
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

  def spares
    supser.merge({ tape_color: tape_color})
  end

  def default_tire_size # サブクラスの初期値
    '23'
  end
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  def initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
    super(args)
  end

  def spares
    super.merge({rear_shock: rear_shock})
  end

  def default_tire_size # サブクラスの初期値
    '2.1'
  end
end

mountain_bike = MountainBike.new(
  size: 'S',
  front_shock: 'Maintou',
  rear_shock: 'Fox'
)

p mountain_bike.size
p mountain_bike.tire_size
p mountain_bike.chain

road_bike = RoadBike.new(
  size: 'M',
  tape_color: 'red'
)

p road_bike.size
p road_bike.tire_size
p road_bike.chain
