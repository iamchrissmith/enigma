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
    # last 7 characters = "..end.."
    # recreate the shift array
    # moving like decrypt (minus)
    # look at the last char of secret
    # - find the shift for that to equal "."
    # - - that gives this_shift+index for one shift value
    # look at the second to last char of secret
    # - find the shift for that to equal "."
    # - - that gives this_shift+index for one shift value
    # keep repeating until look at all "..end.." chars or filled in the entire shift array
  end

  private 

  def negative_shift(shift)
    shift = shift.map {|number| -number}
  end

  def adjust_end_for_shift(secret)
    place = secret.length % 4
    start = -4 - place
    finish = -1 - place
    secret[start..finish].split("")
  end
  
end
