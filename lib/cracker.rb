require './lib/cryptor'

class Cracker < Cryptor

  def initialize(cipher, date)
    key = crack_key(cipher_date)
    super(cipher, key, date)
  end

  def self.crack_key(cipher, date)
    offsets = (date.to_i ** 2).digits.reverse[-4..-1]
    shifter_key = get_shifter_key(cipher)
  end

  def self.get_shift_amounts(cipher)
    character_set = ("a".."z").to_a << " "
    expected_chars = [" ", "e", "n", "d"]
    cipher_last_four = cipher.split(//)[-4..-1]
    expected_chars.map.with_index do |expected_char, i|
      character_set.index(cipher_last_four[i]) - character_set.index(expected_char)
    end
  end


end