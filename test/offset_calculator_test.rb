require './test/test_helper'
require './lib/offset_calculator'

class OffsetCalculatorTest < MiniTest::Test

  attr_reader :offset

  def setup
    @offset = OffsetCalculator.new
  end

  def test_offset_exists
    assert offset
    assert_instance_of OffsetCalculator, offset
  end

  def test_offset_accepts_date_returns_offset
    output = offset.get_offset(Date.new(2017,2,23))
    expect = [7, 0, 8, 9]
    assert_equal expect, output
    assert_instance_of Array, output
    assert_equal 4, output.length
  end

  def test_assign_rotators
    expected = [12,23,34,45]
    assert_equal expected, offset.assign_rotators("12345")
  end

  def test_shift_sums_rotators_and_offset
    expected = [19,23,42,54]
    assert_equal expected, offset.shift("12345",Date.new(2017,2,23))
  end
end
