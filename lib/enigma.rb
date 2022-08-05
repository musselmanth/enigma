class Enigma
  
  def encrypt(message, key = get_key, date = get_date)
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

  def get_key
    rand(100000).to_s.rjust(5, "0")
  end
  
end