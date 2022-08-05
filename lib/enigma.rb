class Enigma
  
  def encrypt(message, key, date = get_date)
    encryptor = Encryptor.new(key, date)
    {
      encryption: encryptor.encrypt(message),
      key: key,
      date: date
    }
  end

  def get_date
    Time.now.strftime("%d%m%y")
  end



end