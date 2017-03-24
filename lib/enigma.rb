require 'pry'
require './lib/key_generator'
require './lib/offset_calculator'

class Enigma

  def initialize
    @alpha = ('a'..'z').to_a

  end

  def encrypt(message, key = nil, date = Date.today)
    key_gen = KeyGenerator.new
    key = key_gen.generate if !key
    offset = OffsetCalculator.new(key, date)
    shift = offset.shift
    letters = message.split('')
    secret = letters.map do |letter|
      index = @alpha.index(letter)
      this_shift = shift[0] % 26
      rotated = @alpha.rotate( this_shift + index )
      shift.rotate!
      rotated[0]
    end
    secret.join('')
  end

  def decrypt(secret, key, date = Date.today)
  end

  def crack(secret, date = Date.today)
  end

end
