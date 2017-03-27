require 'pry'
require './lib/key_generator'
require './lib/offset_calculator'
require './lib/encryptor'

class Enigma

  def initialize
    @encryptor = Encryptor.new
  end
  
  def encrypt(message, key = KeyGenerator.new.generate, date = Date.today)
    offset = OffsetCalculator.new(key, date)
    shift = offset.shift
    letters = message.split('')
    @encryptor.rotate_letters(letters, shift).join('')
  end

  def decrypt(secret, key, date = Date.today)
    offset = OffsetCalculator.new(key, date)
    shift = negative_shift(offset.shift)
    letters = secret.split('')
    @encryptor.rotate_letters(letters, shift).join('')
  end

  def crack(secret, date = Date.today)
    
    start, finish = find_end_adjustment(secret) 
    coded_tail = secret[start..finish].split("")
    tail = "..end.."[start..finish].split("")
    shift = @encryptor.discover_shift(coded_tail, tail)
    shift = negative_shift(shift)
    letters = secret.split('')
    @encryptor.rotate_letters(letters, shift).join('')

    # - - that gives this_shift+index for one shift value (no negatives)

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
  
end
