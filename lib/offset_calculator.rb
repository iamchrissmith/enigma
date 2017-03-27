require 'pry'

class OffsetCalculator

  # attr_reader :key
  # attr_accessor :date

  # def initialize
  #   # @key  = key
  #   # @date = date
  # end

  def get_offset(date)
    today = date.strftime("%d%m%y")
    today = today.to_i ** 2
    offset = today.to_s[-4..-1]
    offset.split('').map! {|s| s.to_i }
  end

  def assign_rotators(key)
    keys = key.split('')
    rotators = []

    (1..4).each do |idx|
      rotators << keys[idx-1] + keys[idx]
    end
    rotators
  end

  def rotators_to_nums(rotators)
    nums = rotators.map do |rotator|
      rotator.to_i
    end
  end

  def shift(key, date = Date.today)
    shifted = []
    rotators = rotators_to_nums( assign_rotators(key) )
    offset = get_offset(date)
    shifted = [rotators,offset].transpose.map {|x| x.reduce(:+)}
  end

end
