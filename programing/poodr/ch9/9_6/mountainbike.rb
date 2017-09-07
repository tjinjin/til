require_relative 'bicycle'

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  def post_initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
  end

  def default_tire_size # サブクラスの初期値
    '2.1'
  end

  def local_spares
    {rear_shock: rear_shock}
  end
end


