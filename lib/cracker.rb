require './lib/cryptor'

class Cracker < Cryptor

  attr_reader :key

  def initialize(encrypted_message, date)
    @key = crack_key(encrypted_message, date)
    super(@key, date, :decrypt)
  end

  def crack_key(encrypted_message, date)
    cipher = segregate_characters(encrypted_message.downcase.split(//))[:remaining_chars]
    offsets = (date.to_i ** 2).digits.reverse[-4..-1]
    shift_amounts = get_shift_amounts(cipher)
    ordered_shift_amounts = order_shift_amounts(shift_amounts, (cipher.length - 1) % 4)
    lowest_key_segments = get_lowest_key_segments(offsets, ordered_shift_amounts)
    possible_key_segments = get_all_possible_key_segments(lowest_key_segments)
    matching_key_segments = get_matching_key_segments(possible_key_segments)
    (puts "Cannot Crack."; exit) if matching_key_segments.empty?
    combine_key_segments(matching_key_segments)
  end

  def get_shift_amounts(cipher)
    expected_chars = [" ", "e", "n", "d"]
    cipher_last_four = cipher[-4..-1]
    expected_chars.map.with_index do |expected_char, i|
      CHARACTER_SET.index(cipher_last_four[i]) - CHARACTER_SET.index(expected_char)
    end
  end

  def order_shift_amounts(shift_amounts, last_cipher_index)
    (3 - last_cipher_index).times{ shift_amounts.rotate! }
    shift_amounts
  end

  def get_lowest_key_segments(offsets, shifts)
    results = shifts.map.with_index{ |shift, i| shift - offsets[i] }
    results.map do |result| 
      until result >= 0
        result += 27
      end
      result
    end
  end

  def get_all_possible_key_segments(lowest_key_segments)
    lowest_key_segments.map.with_index do |key_seg, i|
      possible_key_segs = []
      until key_seg.digits.length > 2
        possible_key_segs << key_seg.to_s.rjust(2, "0")
        key_seg += 27
      end
      possible_key_segs
    end
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
  
  def is_key_solution?(key_segs)
    key_segs[0][1] == key_segs[1][0] &&
    key_segs[1][1] == key_segs[2][0] &&
    key_segs[2][1] == key_segs[3][0]
  end

  def combine_key_segments(key_segments)
    "#{key_segments[0]}#{key_segments[1][1]}#{key_segments[2][1]}#{key_segments[3][1]}"
  end

end