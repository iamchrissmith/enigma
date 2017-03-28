require './test/test_helper'
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

  def test_enigma_runs_encrypt_on_our_names
    chris = e.encrypt("chris ..end..","12345",Date.new(2017,2,23))
    c_output = "v4AD@Rfrx![rI"
    assert_equal c_output, chris
    natalia = e.encrypt("natalia ..end..","12345",Date.new(2017,2,23))
    n_output = "6xC\"45*wIM]IwMf"
    assert_equal n_output, natalia
  end

  def test_enigma_runs_decrypt_on_long_with_special_characters
    first = e.decrypt("tRqwt0BGy7;G36,\"w&1$ci0vNAUwIM]IwMf","12345",Date.new(2017,2,23))
    c_output = "a A adslfkjlkjfadsLKJLK: !@ ..end.."
    assert_equal c_output, first
    second = e.decrypt("/RUwSRVw#RXwBRZwDRbwFRdwHRfwJRhwLRjwPRnwRRfrx![rI","12345",Date.new(2017,2,23))
    n_output = "! @ # $ % ^ & * ( ) [ ] , . < > ; : / ? | ..end.."
    assert_equal n_output, second
  end

  def test_enigma_runs_crack_and_returns_names
    natalia = e.crack("6xC\"45*wIM]IwMf",Date.new(2017,2,23))
    n_output = "natalia ..end.."
    assert_equal n_output, natalia
    chris = e.crack("v4AD@Rfrx![rI",Date.new(2017,2,23))
    c_output = "chris ..end.."
    assert_equal c_output, chris
  end

end
