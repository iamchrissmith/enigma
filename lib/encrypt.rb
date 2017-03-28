require 'pry'
require './lib/key_generator'
require './lib/enigma'

class Encrypt
  
  def initialize(args)
    @enigma = Enigma.new
    @args = args
    file_encrypt
  end

  def file_encrypt
    key = KeyGenerator.new.generate
    message = File.read(@args[0])
    secret = @enigma.encrypt(message, key)
    File.write(@args[1], secret)
    date = Date.today.strftime("%d%m%y")
    puts "Created #{@args[1]} with the key #{key} and date #{date}"
  end
end

Encrypt.new(ARGV)