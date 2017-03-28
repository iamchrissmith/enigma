require 'pry'
require './lib/key_generator'
require './lib/offset_calculator'
require './lib/encryptor'

class Encrypt
  include Encryptor

  def initialize
    @offset = OffsetCalculator.new
  end

  def run(message, key, date)
    shift = @offset.shift(key, date)
    letters = message.split('')
    rotate_letters(letters, shift).join('')
  end

  def file_encrypt(args)
    file_change(args)
  end

end

if !ARGV.empty?
  encrypt = Encrypt.new
  encrypt.file_encrypt(ARGV)
end
