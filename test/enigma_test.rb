require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma.rb'

class EnigmaTest < MiniTest::Test
  attr_reader :e

  def setup
    @e = Enigma.new
  end

  def test_enigma_exists
    assert e
    assert_instance_of Enigma, e
  end

  def test_encryptor_encrypts_our_names
    chris = e.encrypt("chris","12345",Date.new(2017,2,23))
    c_output = "vgjkn"
    assert_equal c_output, chris
    # natalia = e.encrypt("natalia","12345",Date.new(2017,2,23))
    # n_output = ""
    # assert_equal n_output, natalia
  end

end
