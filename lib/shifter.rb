class Shifter
  attr_reader :shift

  def initialize(shift)
    @shift = shift
    @character_set = ("a".."z").to_a << " "
  end

end