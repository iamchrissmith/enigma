module Encryptor
  module_function

  def upper_alpha
    ('A'..'Z').to_a
  end

  def lower_alpha
    ('a'..'z').to_a
  end

  def numbers
    ('0'..'9').to_a
  end

  def symbols
    symbols = %w(! @ $ % ^ & * ( ) [ ] , . < > ; :)
    symbols << [' ', "\"", '/', '?', '|', '#']
    symbols.flatten
  end

  ALPHA = upper_alpha + lower_alpha + numbers + symbols

  def rotate_letters(letters, shift)
    letters.map do |letter|
      index = ALPHA.index(letter)
      this_shift = shift[0]
      rotated = ALPHA.rotate(this_shift)
      shift.rotate!
      rotated[index]
    end
  end

  def file_change(args)
    file_args = parse_file_args(args)
    input_message = get_file_message(file_args[:input])
    output_message = run(input_message, file_args[:key], file_args[:date])
    write_file(file_args[:output], output_message)
    success_message(file_args[:output], file_args[:key], file_args[:date])
  end

  def parse_file_args(args)
    args = {
      input: args[0],
      output: args[1],
      key: args[2] || KeyGenerator.new.generate,
      date: parse_date(args[3])
    }
  end

  def parse_date(text)
    return Date.today if text.nil?

    day = text[0..1].to_i
    month = text[2..3].to_i
    year = ('20' + text[4..5]).to_i
    Date.new(year, month, day)
  end

  def get_file_message(input_file)
    message = File.read(input_file)
    message.delete!("\n") if message.include?("\n")
    message
  end

  def write_file(destination, message)
    File.write(destination, message)
  end

  def success_message(output_file, key, date)
    date = date.strftime('%d%m%y')
    "Created '#{output_file}' with the key #{key} and date #{date}"
  end
end
