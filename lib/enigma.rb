require 'pry'
require './lib/key_generator'
require './lib/offset_calculator'

class Enigma

  def initialize
    @alpha = ('A'..'Z').to_a + ('a'..'z').to_a + ("0".."9").to_a + %w(! @ # $ % ^ & * ( ) [ ] , . < > ; : / ? |) + [" "]
  end
  # should have crypt class with encrypt and decrypt.
  # use these as runners
  def encrypt(message, key = nil, date = Date.today)
    key_gen = KeyGenerator.new
    key = key_gen.generate if !key
    offset = OffsetCalculator.new(key, date)
    shift = offset.shift
    letters = message.split('')
    #move to separate method this will allow using the same method for encrypt/decrypt
    secret = letters.map do |letter|
      index = @alpha.index(letter)
      this_shift = shift[0]
      rotated = @alpha.rotate( this_shift )
      shift.rotate!
      rotated[index]
    end
    secret.join('')
  end

  def decrypt(secret, key, date = Date.today)
    key_gen = KeyGenerator.new
    key = key_gen.generate if !key
    offset = OffsetCalculator.new(key, date)
    shift = offset.shift
    # make shifts negative then pass to method from encrypt
    letters = secret.split('')
    message = letters.map do |letter|
      index = @alpha.index(letter)
      this_shift = shift[0]
      rotated = @alpha.rotate( -this_shift )
      shift.rotate!
      rotated[index]
    end
    message.join('')
  end

  def adjust_end_for_shift(secret)
    # shift array is four numbers
    # length of secret % 4 = place in rotation of shift
    # - move left by the remainder of secret.length % 4 then take the previous four of "..end.."
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

end
