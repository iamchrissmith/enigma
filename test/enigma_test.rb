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
    chris = e.encrypt("chris ..end..","12345",Date.new(2017,2,23))
    c_output = "v4BE@Whtx!)tK"
    assert_equal c_output, chris
    natalia = e.encrypt("natalia ..end..","12345",Date.new(2017,2,23))
    n_output = "6xD/45&1KO[JwOh"
    assert_equal n_output, natalia
  end

  def test_encryptor_encrypts_long_with_special_characters
    first = e.encrypt("a A adslfkjlkjfadsLKJLK: !@ ..end..","12345",Date.new(2017,2,23))
    c_output = "tWq1t0CHy7>H36]/w^1#ci0xSBV1KO[JwOh"
    assert_equal c_output, first
    second = e.encrypt("! @ # $ % ^ & * ( ) [ ] , . < > ; : / ? | ..end..","12345",Date.new(2017,2,23))
    n_output = "?WV1 WX1BWZ1DWb1FWd1HWf1JWh1LWj1NWl1PWn1RWhtx!)tK"
    assert_equal n_output, second
  end

  def test_decryptor_returns_natalia
    natalia = e.decrypt("6xD/45&1KO[JwOh","12345",Date.new(2017,2,23))
    n_output = "natalia ..end.."
    assert_equal n_output, natalia
  end

  def test_decryptor_returns_chris
    chris = e.decrypt("v4BE@Whtx!)tK","12345",Date.new(2017,2,23))
    c_output = "chris ..end.."
    assert_equal c_output, chris
  end

  def test_decryptor_decrypts_long_with_special_characters
    first = e.decrypt("tWq1t0CHy7>H36]/w^1#ci0xSBV1KO[JwOh","12345",Date.new(2017,2,23))
    c_output = "a A adslfkjlkjfadsLKJLK: !@ ..end.."
    assert_equal c_output, first
    second = e.decrypt("?WV1 WX1BWZ1DWb1FWd1HWf1JWh1LWj1NWl1PWn1RWhtx!)tK","12345",Date.new(2017,2,23))
    n_output = "! @ # $ % ^ & * ( ) [ ] , . < > ; : / ? | ..end.."
    assert_equal n_output, second
  end

  def test_adjust_end_for_shift_returns_right_negative_number
    e.adjust_end_for_shift("")
  end

  def test_cracker_returns_names
    skip
    natalia = e.crack("6xD/45&1KO[JwOh",Date.new(2017,2,23))
    n_output = "natalia"
    assert_equal n_output, natalia
    chris = e.decrypt("v4BE@Whtx!)tK",Date.new(2017,2,23))
    c_output = "chris"
    assert_equal c_output, chris
  end

end
