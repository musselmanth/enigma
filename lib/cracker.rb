require './lib/cryptor'

class Cracker < Cryptor

  def initialize(cipher, date)
    key = crack_key(cipher_date)
    super(cipher, key, date)
  end

  def self.crack_key(cipher, date)
    offsets = (date.to_i ** 2).digits.reverse[-4..-1]
    shift_amounts = get_shift_amounts(cipher)
    ordered_shift_amounts = order_shift_amounts(shift_amounts, (cipher.length - 1) % 4)
    raw_key_sements = get_raw_key_segments(offsets, ordered_shift_amounts)
    possible_key_segements = get_possible_key_segments(raw_key_segments)
  end

  def self.get_shift_amounts(cipher)
    character_set = ("a".."z").to_a << " "
    expected_chars = [" ", "e", "n", "d"]
    cipher_last_four = cipher.split(//)[-4..-1]
    expected_chars.map.with_index do |expected_char, i|
      character_set.index(cipher_last_four[i]) - character_set.index(expected_char)
    end
  end

  def self.order_shift_amounts(shift_amounts, last_cipher_index)
    (3 - last_cipher_index).times{ shift_amounts.rotate! }
    shift_amounts
  end

  def self.get_raw_key_segments(offsets, shifts)
    results = shifts.map.with_index{ |shift, i| shift - offsets[i] }
    results.map{ |result| result < 0 ? result + 27 : result }
  end

  def self.get_possible_key_segments(raw_key_segments)
    possible_key_segments = [[],[],[],[]]
    raw_key_segments.each_with_index do |key_seg, i|
      possible_key_seg = key_seg
      until possible_key_seg.digits.length > 2
        possible_key_segments[i] << possible_key_seg
        possible_key_seg += 27
      end
    end
    possible_key_segments
  end


end