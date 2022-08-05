class Enigma
  
  def encrypt(message, key, date)
    encryptor = Encryptor.new(key, date)
    encryptor.encrypt(message)
  end

end