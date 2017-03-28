require 'pry'
require './lib/key_generator'
require './lib/offset_calculator'
require './lib/encryptor'

class Decrypt

  def initialize
    @offset = OffsetCalculator.new
    @encryptor = Encryptor.new
  end

  def run(secret, key, date)
    shift = negative_shift(@offset.shift(key, date))
    letters = secret.split('')
    @encryptor.rotate_letters(letters, shift).join('')
  end

  def file_decrypt(args)
    @encryptor.file_change(args,self)
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
