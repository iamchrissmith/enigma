require './test/test_helper'
require './lib/encrypt.rb'

class EncryptTest < MiniTest::Test
  attr_reader :e
  include Construct::Helpers

  def setup
    @e = Encrypt.new
  end

  def test_encrypt_exists
    assert e
    assert_instance_of Encrypt, e
  end

  def test_encryptor_encrypts_our_names
    chris = e.run("chris ..end..","12345",Date.new(2017,2,23))
    c_output = "v4AD@Rfrx![rI"
    assert_equal c_output, chris
    natalia = e.run("natalia ..end..","12345",Date.new(2017,2,23))
    n_output = "6xC\"45*wIM]IwMf"
    assert_equal n_output, natalia
  end

  def test_encryptor_encrypts_long_with_special_characters
    first = e.run("a A adslfkjlkjfadsLKJLK: !@ ..end..","12345",Date.new(2017,2,23))
    c_output = "tRqwt0BGy7;G36,\"w&1$ci0vNAUwIM]IwMf"
    assert_equal c_output, first
    second = e.run("! @ # $ % ^ & * ( ) [ ] , . < > ; : / ? | ..end..","12345",Date.new(2017,2,23))
    n_output = "/RUwSRVw#RXwBRZwDRbwFRdwHRfwJRhwLRjwPRnwRRfrx![rI"
    assert_equal n_output, second
  end

  def test_encrypt_writes_coded_message_to_file
    within_construct do |construct|
      construct.directory 'test/mock_files' do |dir|
        dir.file 'message.txt', "chris ..end.."
        args = ['message.txt','encrypted.txt', "12345", "230217"]
        message = e.file_encrypt(args)
        assert_equal "v4AD@Rfrx![rI", File.read('encrypted.txt')
        assert_equal "Created 'encrypted.txt' with the key 12345 and date 230217", message
      end
    end
  end

  def test_encrypt_writes_coded_message_to_file_when_message_has_line_breaks
    within_construct do |construct|
      construct.directory 'test/mock_files' do |dir|
        dir.file 'message.txt', "chris ..end..\n\n"
        args = ['message.txt','encrypted.txt', "12345", "230217"]
        message = e.file_encrypt(args)
        assert_equal "v4AD@Rfrx![rI", File.read('encrypted.txt')
        assert_equal "Created 'encrypted.txt' with the key 12345 and date 230217", message
      end
    end
  end

  def test_encrypt_writes_coded_message_to_file_from_command_line
    skip
    File.write('./test/test_files/encrypt_test_message.txt', "chris ..end..")
    message = `ruby ./lib/encrypt.rb ./test/test_files/encrypt_test_message.txt ./test/test_files/encrypt_test_encrypted.txt "12345" "230217"`
    assert_equal "v4AD@Rfrx![rI", File.read('./test/test_files/encrypt_test_encrypted.txt')
    assert_equal "Created './test/test_files/encrypt_test_encrypted.txt' with the key 12345 and date 230217", message
  end

end
