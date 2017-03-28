require 'pry'
require './lib/key_generator'
require './lib/offset_calculator'
require './lib/encryptor'

class Decrypt
  include Encryptor

  def initialize
    @offset = OffsetCalculator.new
  end

  def run(secret, key, date)
    shift = negative_shift(@offset.shift(key, date))
    letters = secret.split('')
    rotate_letters(letters, shift).join('')
  end

  def file_decrypt(args)
    file_change(args)
  end

  private

  def negative_shift(shift)
    shift = shift.map {|number| -number}
  end

end

if !ARGV.empty?
  Decrypt.new(ARGV)
  decrypt.file_encrypt(ARGV)
end
