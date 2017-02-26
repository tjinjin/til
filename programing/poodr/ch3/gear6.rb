class Gear
  attr_reader :chainring, :cog, :wheel
  # hashで受け取る
  def initialize(args)
    @chainring = args[:chainring]
    @cog       = args[:cog]
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

# 冗長にはなるけど、わかりやすくなっているはず
# ハッシュで受け取るかはトレードオフ、影響が少ないならそのままもあり
# 必須パラメータをハッシュで受取り、その他はまとめて受け取るとか
puts Gear.new(chainring: 52,cog: 11, wheel: Wheel.new(26,1.5)).gear_inches
