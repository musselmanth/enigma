class Decryptor

  attr_reader :shifters

  def initialize(key, date)
    @shifters = Shifter.generate_shifters(key, date, :decrypt)
  end

  def decrypt(message)
    characters = message.split(//)
    characters.map.with_index do |character, i|
      @shifters[i % 4].shift_character(character)
    end.join
  end

end