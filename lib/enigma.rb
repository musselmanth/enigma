require './lib/cryptor'
require './lib/cracker'

class Enigma
  
  def encrypt(message, key = nil, date = nil)
    key ||= get_key
    date ||= get_date
    encryptor = Cryptor.new(key, date, :encrypt)
    {
      encryption: encryptor.run(message),
      key: key,
      date: date
    }
  end

  def decrypt(cipher, key, date = nil)
    date ||= get_date
    decryptor = Cryptor.new(key, date, :decrypt)
    {
      decryption: decryptor.run(cipher),
      key: key,
      date: date
    }
  end

  def crack(cipher, date = nil)
    date ||= get_date
    cracker = Cracker.new(cipher, date)
    {
      decryption: cracker.run(cipher),
      date: date,
      key: cracker.key
    }
  end

  def get_date
    Time.now.strftime("%d%m%y")
  end

  def get_key
    rand(100000).to_s.rjust(5, "0")
  end
  
end