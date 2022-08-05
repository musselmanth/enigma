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

  def self.generate_shifters(key, date)
    date_key = (date.to_i ** 2).digits.reverse[-4..-1]
    (0..3).map{ |i| Shifter.new(key[i..i+1].to_i + date_key[i]) }
  end

end