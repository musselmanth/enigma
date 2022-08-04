class Enigma

  def initialize
    @character_set = ("a".."z").to_a << " "
    @encryptor = Encryptor.new
  end
  
  def encrypt(message, key, date)
    @encryptor.encrypt(message, key, date)
  end

end