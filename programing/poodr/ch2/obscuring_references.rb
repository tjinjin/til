class ObscuringReferences
  attr_reader :data
  def initialize(data)
    @data = data
  end

  def diameters
    ## 繰り返しと、選別をしている
    data.collect {|cell|
      cell[0] + cell[1] * 2
    }
  end
end

puts ObscuringReferences.new([[622,20],[622,23],[559,30],[559,40]]).diameters
