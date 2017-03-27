class Encryptor

  def initialize
    @alpha = upper_alpha + lower_alpha + numbers + symbols
  end

  def rotate_letters(letters, shift)
    letters.map do |letter|
        index = @alpha.index(letter)
        this_shift = shift[0]
        rotated = @alpha.rotate( this_shift )
        shift.rotate!
        rotated[index]
      end
  end

  def discover_shift(coded_tail, tail)
    coded_tail.map.with_index do |code, idx|
      coded_index = @alpha.index(code) 
      rotated = @alpha.rotate(coded_index)
      counter = 0
      until rotated[0] == tail[idx]
        rotated = rotated.rotate(-1)
        counter += 1
      end
      counter #- alpha.index(tail[idx])
    end
  end

  private

  def upper_alpha
    ('A'..'Z').to_a
  end

  def lower_alpha
    ('a'..'z').to_a
  end

  def numbers
    ("0".."9").to_a
  end

  def symbols
    symbols = %w(! @ $ % ^ & * ( ) [ ] , . < > ; :)
    symbols << [" ", "\"", "/", "?", "|", "#"]
    symbols.flatten
  end
end
