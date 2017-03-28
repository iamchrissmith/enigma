require 'pry'
require './lib/key_generator'
require './lib/offset_calculator'
require './lib/encryptor'
require './lib/decrypt'

class Crack

  def initialize #(args)
    # @enigma = Enigma.new
    # @args = args
    # file_crack
    @offset = OffsetCalculator.new
    @encryptor = Encryptor.new
    @decrypt = Decrypt.new
    @found_key = ''
  end

  def run(secret, date)
    start, finish = find_end_adjustment(secret)
    coded_tail = secret[start..finish].split("")
    tail = "..end.."[start..finish].split("")
    shift = @encryptor.discover_shift(coded_tail, tail)
    offset = @offset.get_offset(date)
    rotators = [shift,offset].transpose.map {|x| x.reduce(:-)}
    @found_key = reverse_to_key(rotators)
    @decrypt.run(secret, @found_key, date)
  end

  def file_crack(args)
    args = args.insert(2,'') #putting in fake key to normalize args
    file_args = @encryptor.parse_file_args(args)
    secret = @encryptor.get_file_message(file_args[:input])
    message = run(secret, file_args[:date])
    @encryptor.write_file(file_args[:output], message)
    @encryptor.success_message(file_args[:output], @found_key, file_args[:date])
  end

  private
  def find_end_adjustment(secret)
    place = secret.length % 4
    start = -4 - place
    finish = -1 - place
    [start, finish]
  end

  def reverse_to_key(rotators)
    key = rotators.map {|number| number.to_s[0]}
    key << rotators.last.to_s[1]
    key.join("")
  end


end

if !ARGV.empty?
  Crack.new(ARGV)
  crack.file_crack(ARGV)
end
