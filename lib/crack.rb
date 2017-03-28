require 'pry'
require './lib/key_generator'
require './lib/enigma'

class Crack
  
  def initialize(args)
    @enigma = Enigma.new
    @args = args
    file_crack
  end

  def file_crack
    secret = File.read(@args[0])
    date = parse_date(@args[2])
    message = @enigma.crack(secret, date)
    File.write(@args[1], message)
    puts "Created '#{@args[1]}' with the key and date #{@args[2]}"
  end

  def parse_date(text)
    day = text[0..1].to_i
    month = text[2..3].to_i
    year = ("20" + text[4..5]).to_i
    Date.new(year,month,day)
  end
  
end

Crack.new(ARGV)