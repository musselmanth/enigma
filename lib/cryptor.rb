require './lib/shifter'

class Cryptor

  CHARACTER_SET = ("a".."z").to_a << " "

  attr_reader :shifters

  def initialize(key, date, action)
    @shifters = Shifter.generate_shifters(key, date, action)
  end

  def run(input)
    characters = input.downcase.split(//)
    seg_chars = segregate_characters(characters)
    output_chars = seg_chars[:remaining_chars].map.with_index do |character, i|
      @shifters[i % 4].shift_character(character)
    end
    join_characters(output_chars, seg_chars[:removed_chars])
  end

  def segregate_characters(characters)
    result = {removed_chars: {}, remaining_chars: []}
    characters.each_with_index do |char, i|
      if CHARACTER_SET.include?(char) 
        result[:remaining_chars] << char
      else
        result[:removed_chars][i] = char
      end
    end
    result
  end

  def join_characters(output_chars, removed_chars)
    removed_chars.inject(output_chars) do |output_chars, (i, char)|
      output_chars.insert(i, char)
    end.join
  end

end