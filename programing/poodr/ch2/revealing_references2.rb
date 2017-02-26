class RevealingReferences
  attr_reader :wheels
  def initialize(data)
    @wheels = wheelify(data)
  end

  # 繰り返し
  def diameters
    wheels.collect {|wheel| diameter(wheel)}
  end

  # 計算メソッド
  def diameter(wheel)
    wheel.rim + (wheel.tire * 2)
  end

  Wheel = Struct.new(:rim, :tire)
  # data構造を知っているメソッド
  def wheelify(data)
    data.collect {|cell|
      Wheel.new(cell[0], cell[1])
    }
  end
end

puts RevealingReferences.new([[622,20],[622,23],[559,30],[559,40]]).diameters
