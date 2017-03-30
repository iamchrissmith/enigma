require 'pry'
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
    tail = slice_string_to_array(' ..end..', start, finish)
    this_shift = discover_shift(coded_tail, tail)
    @found_key = find_key(this_shift, date)
    @decrypt.run(secret, @found_key, date, this_shift)
  end

  def self.file_crack(args)
    new.file_crack(args)
  end

  def file_crack(args)
    args = args.insert(2, '') # putting in fake key to normalize args
    file_args = parse_file_args(args)
    secret = get_file_message(file_args[:input])
    message = run(secret, file_args[:date])
    write_file(file_args[:output], message)
    success_message(file_args[:output], @found_key, file_args[:date])
  end

  private

  def find_key(this_shift, date)
    offset = @offset.get_offset(date)
    transposed = [this_shift, offset].transpose
    rotators = transposed.map do |x|
      number = x.reduce(:-)
      number += 85 if number <= 0
      number = number.to_s
      number = "0" + number if number.length == 1
      number
    end
    reverse_to_key(rotators)
  end

  def slice_string_to_array(string, start, finish)
    string[start..finish].split('')
  end

  def find_end_adjustment(secret)
    place = secret.length % 4
    start = -4 - place
    finish = -1 - place
    [start, finish]
  end

  def reverse_to_key(rotators)
    doubled_third = false
    key = rotators.map.with_index do |number, idx|
      if !rotators[idx + 1].nil? && number[1] != rotators[idx + 1][0]
        (number.to_i + 85).to_s
        doubled_third = true if idx == 2
      elsif doubled_third && number == rotators.last
        (number.to_i + 85).to_s
      end
      number[0]
    end
    key << rotators.last[1]
    key.join('')
  end

  def check_shift(shift, other_code, other_letter)
    test_letters = rotate_letters([other_code][-shift])
    test_letters.include?(other_letter)
  end

  def discover_shift(coded_tail, tail)
    coded_tail.map.with_index do |code, idx|
      tail_index = ALPHA.index(tail[idx])
      coded_index = ALPHA.index(code)
      this_shift = (coded_index - tail_index)
      this_shift += 85 if this_shift < 0
      this_shift
    end
  end
end

print Crack.new.file_crack(ARGV) unless ARGV.empty?
