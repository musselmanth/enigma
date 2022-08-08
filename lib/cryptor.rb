require './lib/shifter'

class Cryptor

  CHARACTER_SET = ("a".."z").to_a << " "

  attr_reader :shifters

  def initialize(key, date, action)
    @shifters = Shifter.generate_shifters(key, date, action)
  end

  def run(input)
    characters = input.downcase.split(//)
    split_chars = remove_characters(characters)
    characters = split_chars[:remaining_chars]
    removed_chars = split_chars[:removed_chars]
    encrypted = characters.map.with_index do |character, i|
      @shifters[i % 4].shift_character(character)
    end.join
    # final_encryption = insert_removed_chars(encrypted, removed_chars)
    # final_encryption.join
  end

  def remove_characters(characters)
    removed_chars = {}
    remaining_chars = []
    characters.each_with_index do |char, i|
      CHARACTER_SET.include?(char) ? remaining_chars << char : removed_chars[i] = char
    end
    {removed_chars: removed_chars, remaining_chars: remaining_chars}
  end



end