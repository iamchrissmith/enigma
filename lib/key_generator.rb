require 'pry'

class KeyGenerator
  def random_number_as_string
    rand(10).to_s
  end

  def generate
    key = ''
    5.times do
      key += random_number_as_string
    end
    key
  end
end
