class Encryptor

  def initialize
    @character_set = ("a".."z").to_a << " "
  end

  def encrypt(message, key, date)
    generate_shifters(key, date)
  end

end