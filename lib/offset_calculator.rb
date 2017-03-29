require 'pry'

class OffsetCalculator
  def get_offset(date)
    today = date.strftime('%d%m%y')
    today = today.to_i**2
    offset = today.to_s[-4..-1]
    offset.split('').map!(&:to_i) # { |s| s.to_i }
  end

  def assign_rotators(key)
    keys = key.split('')
    rotators = []

    (1..4).each do |idx|
      rotators << keys[idx - 1] + keys[idx]
    end
    rotators.map(&:to_i)
  end

  def shift(key, date)
    rotators = assign_rotators(key)
    offset = get_offset(date)
    [rotators, offset].transpose.map { |x| x.reduce(:+) }
  end
end
