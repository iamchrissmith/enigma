require 'pry'
require './lib/key_generator'
require './lib/offset_calculator'
require './lib/encryptor'

class Enigma

  def initialize
    @encryptor = Encryptor.new
    @offset = OffsetCalculator.new
  end
  
  def encrypt(message, key = KeyGenerator.new.generate, date = Date.today)
    shift = @offset.shift(key, date)
    letters = message.split('')
    @encryptor.rotate_letters(letters, shift).join('')
  end

  def decrypt(secret, key, date = Date.today)
    shift = negative_shift(@offset.shift(key, date))
    letters = secret.split('')
    @encryptor.rotate_letters(letters, shift).join('')
  end

  def crack(secret, date = Date.today)
    start, finish = find_end_adjustment(secret) 
    coded_tail = secret[start..finish].split("")
    tail = "..end.."[start..finish].split("")
    shift = @encryptor.discover_shift(coded_tail, tail)
    offset = @offset.get_offset(date)
    rotators = [shift,offset].transpose.map {|x| x.reduce(:-)}
    key = reverse_to_key(rotators)
    decrypt(secret, key, date)
  end

  private 

  def negative_shift(shift)
    shift = shift.map {|number| -number}
  end

  def find_end_adjustment(secret)
    place = secret.length % 4
    start = -4 - place
    finish = -1 - place
    [start, finish]
  end
  
  def reverse_to_key(rotators)
    key = rotators.map {|number| number.to_s[0]}
    key << rotators.last.to_s[1]
    key.join("")
  end
  
end
