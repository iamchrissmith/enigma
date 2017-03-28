require './test/test_helper'
require './lib/encryptor.rb'

class EncryptorTest < MiniTest::Test
  attr_reader :encryptor

  def setup
    @encryptor = Encryptor.new
  end

  def test_encryptor_exists
      assert_instance_of Encryptor, encryptor
  end

  def test_if_rotate_letters_output_is_an_array
    output = encryptor.rotate_letters(["a","b","c","d"],[19, 23, 42, 54])

    assert_instance_of Array, output
  end

  def test_if_rotates_letter
    expected = ["b", "d", "f", "h"]
    output = encryptor.rotate_letters(["a","b","c","d"],[1, 2, 3, 4])

    assert_equal expected, output
  end
end
