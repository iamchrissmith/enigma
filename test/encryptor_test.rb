require './test/test_helper'
require './lib/encryptor.rb'

class EncryptorTest < MiniTest::Test
  include Encryptor

  def test_if_rotate_letters_output_is_an_array
    output = rotate_letters(["a","b","c","d"],[19, 23, 42, 54])

    assert_instance_of Array, output
  end

  def test_if_rotates_letter
    expected = ["b", "d", "f", "h"]
    output = rotate_letters(["a","b","c","d"],[1, 2, 3, 4])

    assert_equal expected, output
  end
end
