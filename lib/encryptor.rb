require 'pry'
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
      counter
    end
  end

  def file_change(args,action)
    file_args = parse_file_args(args)
    secret = get_file_message(file_args[:input])
    message = action.run(secret, file_args[:key], file_args[:date])
    write_file(file_args[:output], message)
    success_message(file_args[:output], file_args[:key], file_args[:date])
  end


  def parse_file_args(args)
    args = {
      input: args[0],
      output: args[1],
      key: args[2] || KeyGenerator.new.generate,
      date: parse_date(args[3]) || Date.today
    }
  end

  def parse_date(text)
    day = text[0..1].to_i
    month = text[2..3].to_i
    year = ("20" + text[4..5]).to_i
    Date.new(year,month,day)
  end

  def get_file_message(input_file)
    message = File.read(input_file)
    message.gsub!("\n", '') if message.include?("\n")
    message
  end

  def write_file(destination, message)
    File.write(destination, message)
  end

  def success_message(output_file, key, date)
    date = date.strftime("%d%m%y")
    "Created '#{output_file}' with the key #{key} and date #{date}"
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
