class Player
  attr_accessor :name, :marker

  def initialize(marker, disp)
    raise "Player's marker must be a :x or :o" unless marker.eql?(:x) or marker.eql?(:o)
    @marker= marker
    @display = disp
  end

  def move(board)
    raise 'No User'
  end
end