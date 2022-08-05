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

  def self.get_shifter_key(cipher)
    expected_chars = [" ", "e", "n", "d"]
    ((cipher.length - 4) % 4).times{ expected_chars.rotate! }
    expected_chars
  end


end