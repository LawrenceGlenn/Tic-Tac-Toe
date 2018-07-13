class Player
  attr_accessor :name, :marker

  def initialize(marker, disp)
    raise "Player's marker must be a :x or :o" unless marker.eql?(:x) or marker.eql?(:o)
    @marker= marker
    @display = disp
  end

  def get_move(board, rules)
    raise 'No User'
  end
end