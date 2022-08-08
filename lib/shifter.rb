class Shifter

  CHARACTER_SET = ("a".."z").to_a << " "

  attr_reader :shift

  def initialize(shift)
    @shift = shift
  end

  def shift_character(character)
    character.downcase!
    new_character_index = (CHARACTER_SET.index(character) + @shift) % 27
    CHARACTER_SET[new_character_index]
  end

  def self.generate_shifters(key, date, action)
    offsets = (date.to_i ** 2).digits.reverse[-4..-1]
    reversor = (action == :decrypt ? -1 : 1)
    (0..3).map{ |i| Shifter.new(reversor * (key[i..i+1].to_i + offsets[i])) }
  end

end