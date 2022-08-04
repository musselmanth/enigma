class Enigma

  def initialize
    @encryptor = Encryptor.new
  end
  
  def encrypt(message, key, date)
    @encryptor.encrypt(message, key, date)
  end

end