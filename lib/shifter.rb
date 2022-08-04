class Shifter

  attr_reader :shift

  def initialize(shift)
    @shift = shift
    @character_set = ("a".."z").to_a << " "
  end

  def encrypt_character(character)
    character.downcase!
    if @character_set.include?(character)
      new_character_index = (@character_set.index(character) + @shift) % 27
      @character_set[new_character_index]
    else
      character
    end
  end

end