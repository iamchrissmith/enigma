require './test/test_helper'
require './lib/crack.rb'

class CrackTest < MiniTest::Test
  include Construct::Helpers
  attr_reader :e

  def setup
    @e = Crack.new
  end

  def test_crack_exists
    assert e
    assert_instance_of Crack, e
  end

  def test_cracker_returns_names
    # skip
    natalia = e.run("6xC\"45*wIM]IwMf",Date.new(2017,2,23))
    n_output = "natalia ..end.."
    assert_equal n_output, natalia
    chris = e.run("v4AD@Rfrx![rI",Date.new(2017,2,23))
    c_output = "chris ..end.."
    assert_equal c_output, chris
  end

  def test_crack_writes_decoded_message_to_file
    # skip
    within_construct do |construct|
      construct.directory 'test/mock_files' do |dir|
        dir.file 'encrypted.txt', "v4AD@Rfrx![rI"
        args = ['encrypted.txt', 'message.txt', "230217"]
        message = e.file_crack(args)
        assert_equal "chris ..end..", File.read('message.txt')
        assert_equal "Created 'message.txt' with the key 12345 and date 230217", message
      end
    end
  end

  def test_crack_writes_decoded_message_to_file_when_message_has_line_breaks
    # skip
    within_construct do |construct|
      construct.directory 'test/mock_files' do |dir|
        dir.file 'encrypted.txt', "v4AD@Rfrx![rI\n\n"
        args = ['encrypted.txt', 'message.txt', "230217"]
        message = e.file_crack(args)
        assert_equal "chris ..end..", File.read('message.txt')
        assert_equal "Created 'message.txt' with the key 12345 and date 230217", message
      end
    end
  end

  def test_crack_writes_decoded_message_to_file_from_command_line
    File.write('./test/test_files/crack_test_encrypted_message.txt', "v4AD@Rfrx![rI")
    message = `ruby ./lib/crack.rb ./test/test_files/crack_test_encrypted_message.txt ./test/test_files/crack_test_decoded_message.txt 230217`
    assert_equal "chris ..end..", File.read('./test/test_files/crack_test_decoded_message.txt')
    assert_equal "Created './test/test_files/crack_test_decoded_message.txt' with the key 12345 and date 230217", message
  end

  def test_bulk_crack_test
    1.times do |n|
      File.write('./test/test_files/encrypt_test_message.txt', "#{n}: chris ..end..")
      encrypt_message = `ruby ./lib/encrypt.rb ./test/test_files/encrypt_test_message.txt ./test/test_files/encrypt_test_encrypted.txt 77777 300317`
      puts encrypt_message
      message = `ruby ./lib/crack.rb ./test/test_files/encrypt_test_encrypted.txt ./test/test_files/crack_test_decoded_message.txt 300317`
      puts message
      assert_equal "#{n}: chris ..end..", File.read('./test/test_files/crack_test_decoded_message.txt')
    end
    1.times do |n|
      File.write('./test/test_files/encrypt_test_message.txt', "#{n}: chris ..end..")
      encrypt_message = `ruby ./lib/encrypt.rb ./test/test_files/encrypt_test_message.txt ./test/test_files/encrypt_test_encrypted.txt 99999 300317`
      puts encrypt_message
      message = `ruby ./lib/crack.rb ./test/test_files/encrypt_test_encrypted.txt ./test/test_files/crack_test_decoded_message.txt 300317`
      puts message
      assert_equal "#{n}: chris ..end..", File.read('./test/test_files/crack_test_decoded_message.txt')
    end
    1.times do |n|
      File.write('./test/test_files/encrypt_test_message.txt', "#{n}: chris ..end..")
      encrypt_message = `ruby ./lib/encrypt.rb ./test/test_files/encrypt_test_message.txt ./test/test_files/encrypt_test_encrypted.txt 111111 300317`
      message = `ruby ./lib/crack.rb ./test/test_files/encrypt_test_encrypted.txt ./test/test_files/crack_test_decoded_message.txt 300317`
      assert_equal "#{n}: chris ..end..", File.read('./test/test_files/crack_test_decoded_message.txt')
    end
  end

  # COMMENTING OUT PRIVATE FUNCTION TESTS
    # def test_if_discovers_shift_easy
    #   expected = [1, 2, 3, 4]
    #   output = @e.discover_shift(["b", "d", "f", "h"],["a","b","c","d"])
    #
    #   assert_equal expected, output
    # end
    #
    # def test_if_discovers_shift_spicy
    #   expected = [19,23,42,54]
    #   output = @e.discover_shift(["x","!","[","r"],["e","n","d","."])
    #
    #   assert_equal expected, output
    # end

    # def test_adjust_end_for_shift_returns_right_negative_number
    #   output = e.adjust_end_for_shift("v4AD@Rfrx![rI")
    #   assert_equal ["x", "!", "[", "r"], output
    # end

end
