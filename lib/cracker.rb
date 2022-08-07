require './lib/cryptor'

class Cracker < Cryptor

  attr_reader :key

  def initialize(cipher, date)
    @key = crack_key(cipher, date)
    super(@key, date, :decrypt)
  end

  def crack_key(cipher, date)
    offsets = (date.to_i ** 2).digits.reverse[-4..-1]
    shift_amounts = get_shift_amounts(cipher)
    ordered_shift_amounts = order_shift_amounts(shift_amounts, (cipher.length - 1) % 4)
    raw_key_segments = get_raw_key_segments(offsets, ordered_shift_amounts)
    possible_key_segments = get_possible_key_segments(raw_key_segments)
    matching_key_segments = get_matching_key_segments(possible_key_segments)
    combine_key_segments(matching_key_segments)
  end

  def get_shift_amounts(cipher)
    character_set = ("a".."z").to_a << " "
    expected_chars = [" ", "e", "n", "d"]
    cipher_last_four = cipher.split(//)[-4..-1]
    expected_chars.map.with_index do |expected_char, i|
      character_set.index(cipher_last_four[i]) - character_set.index(expected_char)
    end
  end

  def order_shift_amounts(shift_amounts, last_cipher_index)
    (3 - last_cipher_index).times{ shift_amounts.rotate! }
    shift_amounts
  end

  def get_raw_key_segments(offsets, shifts)
    results = shifts.map.with_index{ |shift, i| shift - offsets[i] }
    results.map{ |result| result < 0 ? result + 27 : result }
  end

  def get_possible_key_segments(raw_key_segments)
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

  def get_matching_key_segments(possible_key_segments)
    solution = []
    possible_key_segments[0].each do |a_key|
      possible_key_segments[1].each do |b_key|
        possible_key_segments[2].each do |c_key|
          possible_key_segments[3].each do |d_key|
            possible_solution = [a_key, b_key, c_key, d_key]
            solution = possible_solution if is_key_solution?(possible_solution)
          end
        end
      end
    end
    solution
  end

  def is_key_solution?(key_segments)
    is_matching_segments?(key_segments[0], key_segments[1]) &&
    is_matching_segments?(key_segments[1], key_segments[2]) &&
    is_matching_segments?(key_segments[2], key_segments[3])
  end

  def is_matching_segments?(segment1, segment2)
    segment1 = segment1.to_s.rjust(2, "0")
    segment2 = segment2.to_s.rjust(2, "0")
    segment1[-1] == segment2[0]
  end

  def combine_key_segments(key_segments)
    str_key_segments = key_segments.map{|segment| segment.to_s.rjust(2, "0")}
    "#{str_key_segments[0]}#{str_key_segments[1][1]}#{str_key_segments[2][1]}#{str_key_segments[3][1]}"
  end

end