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
