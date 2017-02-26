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

# Gearが外部インターフェースの一部の場合
module SomeFramework
  class Gear
    attr_reader :chainring, :cog, :wheel
    def initialize(chainring, cog, wheel)
      @chainring = chainring
      @cog = cog
      @wheel = wheel
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
end

# 外部インターフェースをラップし、自身を変更から守る
# ファクトリーと呼ぶらしい
module GearWrapper
  def self.gear(args)
    SomeFramework::Gear.new(args[:chainring],
                            args[:cog],
                            args[:wheel])
  end
end

# 引数を持つハッシュを渡すことでGearのインスタンス作成できるようになった
p GearWrapper.gear(
  chainring: 52,
  cog: 11,
  wheel: Wheel.new(26, 1.5)
).gear_inches

