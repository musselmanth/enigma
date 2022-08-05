require './lib/cryptor'

class Enigma
  
  def encrypt(message, key = get_key, date = get_date)
    encryptor = Cryptor.new(key, date, :encrypt)
    {
      encryption: encryptor.run(message),
      key: key,
      date: date
    }
  end

  def decrypt(cipher, key, date = get_date)
    decryptor = Cryptor.new(key, date, :decrypt)
    {
      decryption: decryptor.run(cipher),
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