class Enigma
  
  def encrypt(message, key, date)
    encryptor = Encryptor.new(key, date)
    {
      encryption: encryptor.encrypt(message),
      key: key,
      date: date
    }
  end

end