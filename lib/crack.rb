require 'pry'
require './lib/key_generator'
require './lib/offset_calculator'
require './lib/encryptor'
require './lib/decrypt'

class Crack
  include Encryptor

  def initialize
    @offset = OffsetCalculator.new
    @decrypt = Decrypt.new
    @found_key = ''
  end

  def run(secret, date)
    start, finish = find_end_adjustment(secret)
    coded_tail = slice_string_to_array(secret, start, finish)
    tail = slice_string_to_array('..end..', start, finish)
    @found_key = find_key(coded_tail, tail, date)
    @decrypt.run(secret, @found_key, date)
  end

  def file_crack(args)
    args = args.insert(2,'') #putting in fake key to normalize args
    file_args = parse_file_args(args)
    secret = get_file_message(file_args[:input])
    message = run(secret, file_args[:date])
    write_file(file_args[:output], message)
    success_message(file_args[:output], @found_key, file_args[:date])
  end

  private
  def find_key(coded_tail, tail, date)
    shift = discover_shift(coded_tail, tail)
    offset = @offset.get_offset(date)
    rotators = [shift,offset].transpose.map {|x| x.reduce(:-)}
    reverse_to_key(rotators)
  end

  def slice_string_to_array(string, start, finish)
    string[start..finish].split("")
  end

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

  def discover_shift(coded_tail, tail)
    coded_tail.map.with_index do |code, idx|
      coded_index = ALPHA.index(code)
      rotated = ALPHA.rotate(coded_index)
      counter = 0
      until rotated[0] == tail[idx]
        rotated = rotated.rotate(-1)
        counter += 1
      end
      counter
    end
  end
end

unless ARGV.empty?
  Crack.new
  print crack.file_crack(ARGV)
end
