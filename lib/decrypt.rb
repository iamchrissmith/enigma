require 'pry'
require './lib/key_generator'
require './lib/offset_calculator'
require './lib/encryptor'

class Decrypt
  include Encryptor

  def initialize
    @offset = OffsetCalculator.new
  end

  def run(secret, key, date, shift = nil)
    shift = @offset.shift(key, date) if !shift
    shift = negative_shift(shift)
    letters = secret.split('')
    rotate_letters(letters, shift).join('')
  end

  def file_decrypt(args)
    file_change(args)
  end

  private

  def negative_shift(shift)
    # shift.map {|number| -number}
    shift.map(&:-@)
  end
end

if __FILE__ == $0 && ARGV
    decrypt = Decrypt.new
    print decrypt.file_decrypt(ARGV)
end
