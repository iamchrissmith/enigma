require 'pry'
require './lib/key_generator'
require './lib/offset_calculator'
require './lib/encryptor'
require './lib/encrypt'
require './lib/decrypt'
require './lib/crack'

class Enigma

  def encrypt(message, key = KeyGenerator.new.generate, date = Date.today)
      encrypt = Encrypt.new()
      encrypt.run(message, key, date)
  end

  def decrypt(secret, key = KeyGenerator.new.generate, date = Date.today)
      decrypt = Decrypt.new()
      decrypt.run(secret, key, date)
  end

  def crack(secret, date = Date.today)
    crack = Crack.new()
    crack.run(secret, date)
  end

end
