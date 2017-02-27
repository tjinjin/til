# sparesはアンチパターン
class Bicycle
  # front,rearはマウンテンバイク固有のもの
  # styleは種別
  attr_reader :style, :size, :tape_color,
              :front_shock, :rear_shock

  def initialize(args)
    @style = args[:style]
    @size = args[:size]
    @tape_color = args[:tape_color]
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
  end

  # "style"の確認は危険は道への一歩
  # すべての自転車はデフォルト値として
  # 同じタイヤサイズとチェーンサイズを持つ
  def spares
    if style == :road
      {
        chain: '10-speed',
        tire_size: '23', # milimeters
        tape_color: tape_color
      }
    else
      {
        chain: '10-speed',
        tire_size: '2.1', # inches
        rear_shock: rear_shock
      }
    end
  end
  # ほかにもメソッドたくさん
end

bike = Bicycle.new(
  style: :mountain,
  size: 'S',
  front_shock: 'Manitou',
  rear_shock: 'Fox'
)

p bike.spares
