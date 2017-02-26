# メソッドを追加
# ギアインチも影響することが判明した
class Gear
  attr_reader :chainring, :cog, :rim, :wheel
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog       = cog
    @rim       = rim
    @wheel     = Wheel.new(rim, tire)
  end

  def ratio
    chainring / cog.to_f
  end

  # 比率計算だけにした
  def gear_inches
    ratio * wheel.diameter
  end

  # Wheelをクラスに切り出すかは後回しにしている
  Wheel = Struct.new(:rim, :tire) do
    def diameter
      rim + (tire * 2)
    end
  end
end

puts Gear.new(52,11,26,1.5).gear_inches
puts Gear.new(52,11,24,1.25).gear_inches
# puts Gear.new(30,27).ratio gear1のコードが動かなくなる
