# 具象クラスから始める
class Bicycle
  # sizeは全体のサイズ、tape_colorはハンドルバーのテープカラー
  attr_reader :size, :tape_color

  def initialize(args)
    @size = args[:size]
    @tape_color = args[:tape_color]
  end

  # すべての自転車はデフォルト値として
  # 同じタイヤサイズとチェーンサイズを持つ
  def spares
    {
      chain: '10-speed',
      tire_size: '23',
      tape_color: tape_color
    }
  end

  # ほかにもメソッドたくさん
end

bike = Bicycle.new(
  size: 'M',
  tape_color: 'red'
)

p bike.size
p bike.spares
