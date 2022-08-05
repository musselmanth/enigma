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
    key_segments = {a: key[0..1].to_i, b: key[1..2].to_i, c: key[2..3].to_i, d: key[3..4].to_i}
    date_key = (date.to_i ** 2).digits.reverse[-4..-1]
    offsets = {a: date_key[0], b: date_key[1], c: date_key[2], d: date_key[3]}
    {
      a: Shifter.new(key_segments[:a] + offsets[:a]),
      b: Shifter.new(key_segments[:b] + offsets[:b]),
      c: Shifter.new(key_segments[:c] + offsets[:c]),
      d: Shifter.new(key_segments[:d] + offsets[:d])
    }
  end

  private

end