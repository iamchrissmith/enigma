require './test/test_helper'
require './lib/decrypt.rb'

class DecryptTest < MiniTest::Test
  include Construct::Helpers
  attr_reader :e

  def setup
    @e = Decrypt.new
  end

  def test_decrypt_exists
    assert e
    assert_instance_of Decrypt, e
  end

  def test_decryptor_returns_natalia
    natalia = e.run("6xC\"45*wIM]IwMf","12345",Date.new(2017,2,23))
    n_output = "natalia ..end.."
    assert_equal n_output, natalia
  end

  def test_decryptor_returns_chris
    chris = e.run("v4AD@Rfrx![rI","12345",Date.new(2017,2,23))
    c_output = "chris ..end.."
    assert_equal c_output, chris
  end

  def test_decryptor_decrypts_long_with_special_characters
    first = e.run("tRqwt0BGy7;G36,\"w&1$ci0vNAUwIM]IwMf","12345",Date.new(2017,2,23))
    c_output = "a A adslfkjlkjfadsLKJLK: !@ ..end.."
    assert_equal c_output, first
    second = e.run("/RUwSRVw#RXwBRZwDRbwFRdwHRfwJRhwLRjwPRnwRRfrx![rI","12345",Date.new(2017,2,23))
    n_output = "! @ # $ % ^ & * ( ) [ ] , . < > ; : / ? | ..end.."
    assert_equal n_output, second
  end

  def test_decrypt_writes_decoded_message_to_file
    within_construct do |construct|
      construct.directory 'test/mock_files' do |dir|
        dir.file 'encrypted.txt', "v4AD@Rfrx![rI"
        args = ['encrypted.txt', 'message.txt', "12345", "230217"]
        message = e.file_decrypt(args)
        assert_equal "chris ..end..", File.read('message.txt')
        assert_equal "Created 'message.txt' with the key 12345 and date 230217", message
      end
    end
  end

  def test_decrypt_writes_decoded_message_to_file_when_message_has_line_breaks
    within_construct do |construct|
      construct.directory 'test/mock_files' do |dir|
        dir.file 'encrypted.txt', "v4AD@Rfrx![rI\n\n"
        args = ['encrypted.txt', 'message.txt', "12345", "230217"]
        message = e.file_decrypt(args)
        assert_equal "chris ..end..", File.read('message.txt')
        assert_equal "Created 'message.txt' with the key 12345 and date 230217", message
      end
    end
  end

  def test_decrypt_writes_decoded_message_to_file_from_command_line
    skip
    File.write('./test/test_files/decrypt_test_encrypted_message.txt', "v4AD@Rfrx![rI")
    message = `ruby ./lib/decrypt.rb ./test/test_files/decrypt_test_encrypted_message.txt ./test/test_files/decrypt_test_decoded_message.txt "12345" "230217"`
    assert_equal "chris ..end..", File.read('./test/test_files/decrypt_test_decoded_message.txt')
    assert_equal "Created './test/test_files/decrypt_test_decoded_message.txt' with the key 12345 and date 230217", message
  end

end
