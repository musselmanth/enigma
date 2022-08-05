class Encryptor

  attr_reader :key, :date, :shifters

  def initialize(key, date)
    @key = key
    @date = date
    @shifters = Shifter.generate_shifters(key, date)
  end

  def encrypt(message)
    characters = message.split(//)
    encrypted = characters.map.with_index do |character, i|
      @shifters[i % 4].encrypt_character(character)
    end.join
    { encryption: encrypted, key: @key, date: @date }
  end

end