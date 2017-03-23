require 'pry'

class KeyGenerator
  def get_random
    rand(10).to_s
  end

  def generate
    key = ''
    5.times do
      key += get_random
    end
    key
  end
end
