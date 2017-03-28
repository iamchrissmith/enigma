require 'pry'
require './lib/key_generator'
require './lib/offset_calculator'
require './lib/encryptor'

class Encrypt

  def initialize
    @offset = OffsetCalculator.new
    @encryptor = Encryptor.new
  end

  def run(message, key, date)
    shift = @offset.shift(key, date)
    letters = message.split('')
    @encryptor.rotate_letters(letters, shift).join('')
  end

  def file_encrypt(args)
    @encryptor.file_change(args,self)
  end

end

if !ARGV.empty?
  encrypt = Encrypt.new
  encrypt.file_encrypt(ARGV)
end
