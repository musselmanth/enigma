require './lib/shifter'

class Cryptor

  attr_reader :shifters

  def initialize(key, date, action)
    @shifters = Shifter.generate_shifters(key, date, action)
  end

  def run(input)
    characters = input.split(//)
    characters.map.with_index do |character, i|
      @shifters[i % 4].shift_character(character)
    end.join
  end

end