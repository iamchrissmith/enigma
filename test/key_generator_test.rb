require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/key_generator'

class KeyGeneratorTest < MiniTest::Test
    attr_reader :key

    def setup
        @key = KeyGenerator.new 
    end

    def test_key_generator_exists
        assert key
        assert_instance_of KeyGenerator, key
    end
    
    def test_key_generates_key_of_five_characters
        new_key = key.generate
        assert new_key
        assert_equal 5, new_key.length
    end

    def test_key_consists_of_five_numbers
        new_key = key.generate
        new_key = new_key.split("")
        valid = ("0".."9").to_a

        new_key.each do |char|
            assert valid.include?(char)
        end
    end
end

