class Encryptor

  attr_reader :shifters

  def initialize(key, date)
    @shifters = Shifter.generate_shifters(key, date)
  end

  def encrypt(message)
    characters = message.split(//)
    characters.map.with_index do |character, i|
      @shifters[i % 4].encrypt_character(character)
    end.join
  end

end