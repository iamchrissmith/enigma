require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/offset_calculator'

class OffsetCalculatorTest < MiniTest::Test

  attr_reader :offset,
              :offset_date

  def setup
    @offset = OffsetCalculator.new("12345")
    @offset_date = OffsetCalculator.new("12345", Date.new(2017,2,23))
  end

  def test_offset_exists
    assert offset
    assert_instance_of OffsetCalculator, offset
  end

  def test_default_date_is_today
    assert_equal Date.today, offset.date
  end

  def test_get_offset_returns_with_default_date
    today = Date.today.strftime("%d%m%y")
    today = today.to_i ** 2
    expect = today.to_s[-4..-1]
    assert_equal expect, offset.get_offset
    assert_instance_of String, offset.get_offset
    assert_equal 4, offset.get_offset.length
  end

  def test_offset_accepts_date_returns_offset
    today = Date.new(2017,2,23).strftime("%d%m%y")
    today = today.to_i ** 2
    expect = today.to_s[-4..-1]
    assert_equal expect, offset_date.get_offset
    assert_instance_of String, offset_date.get_offset
    assert_equal 4, offset_date.get_offset.length
  end

  def test_assign_rotators
    expected = ["12","23","34","45"]
    assert_equal expected, offset.assign_rotators
  end

  def test_rotators_to_nums
    rotators = ["12","23","34","45"]
    expected = [12,23,34,45]
    assert_equal expected, offset.rotators_to_nums(rotators)
  end

  def test_shift_sums_rotators_and_offset
    expected = [19,23,42,54]
    assert_equal expected, offset_date.shift
  end
end
