require 'pry'
require './lib/key_generator'
require './lib/enigma'

class Decrypt
  
  def initialize(args)
    @enigma = Enigma.new
    @args = args
    file_decrypt
  end

  def file_decrypt
    secret = File.read(@args[0])
    date = parse_date(@args[3])
    message = @enigma.decrypt(secret, @args[2], date)
    File.write(@args[1], message)
    puts "Created '#{@args[1]}' with the key #{@args[2]} and date #{@args[3]}"
  end

  def parse_date(text)
    day = text[0..1].to_i
    month = text[2..3].to_i
    year = ("20" + text[4..5]).to_i
    Date.new(year,month,day)
  end
  
end

Decrypt.new(ARGV)