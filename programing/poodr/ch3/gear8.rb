class Gear
  attr_reader :chainring, :cog, :wheel
  # デフォルト値を決めとく
  def initialize(args)
    # 真偽値を引数にしたり、falseとnilの区別が必要なときはfetchを使う
    # chainringがハッシュにないときデフォルト値を使う
    @chainring = args.fetch(:chainring, 40)
    @cog       = args.fetch(:cog, 18)
    @wheel     = args[:wheel]
  end

  def gear_inches
    # 恐ろしい計算
    ratio * diameter
    # 恐ろしい計算
  end

  def diameter
    wheel.diameter
  end

  def wheel
    @wheel ||= Wheel.new(rim, tire)
  end

  def ratio
    chainring / cog.to_f
  end
end

class Wheel
  attr_reader :rim, :tire
  def initialize(rim, tire)
    @rim = rim
    @tire = tire
  end

  def diameter
    rim + (tire * 2)
  end
end

puts Gear.new(chainring: 52,cog: 11, wheel: Wheel.new(26,1.5)).gear_inches
# nilを渡すことも可能
puts Gear.new(wheel: Wheel.new(26,1.5)).gear_inches
