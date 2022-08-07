require './lib/enigma.rb'

def run
  #if no key provided but date is provided, put date into ARGV[3] place and set key arg to nil.
  if ARGV[2] && ARGV[2].length == 6
    ARGV[3] = ARGV[2]
    ARGV[2] = nil
  end

  unless valid_arguments?
    invalid_arguments_output
    exit
  end

  input_file_path = ARGV[0]
  output_file_path = ARGV[1]
  key = ARGV[2]
  date = ARGV[3]

  input = File.open(input_file_path, "r")
  output = File.open(output_file_path, "w")
  message = input.read

  enigma = Enigma.new
  encrypted = enigma.encrypt(message, key, date)
  output.write(encrypted[:encryption])

  puts "Created '#{output_file_path}' with the key #{encrypted[:key]} and the date #{encrypted[:date]}."
end

def valid_arguments?
  ( ARGV.length == 2 || ARGV.length == 3 || ARGV.length == 4 ) &&
  ARGV[0][-4..-1] == ".txt" &&
  ARGV[1][-4..-1] == ".txt"
  (ARGV[2] ? ARGV[2].length == 5 : true) &&
  (ARGV[2] ? ARGV[2].to_i.to_s.rjust(5, "0") == ARGV[2] : true) &&
  (ARGV[3] ? ARGV[3].length == 6 : true) && 
  (ARGV[3] ? ARGV[3].to_i.to_s.rjust(6, "0") == ARGV[3] : true )
end

def invalid_arguments_output
  puts
  puts "Please include two .txt input and output file names formatted like the example below."
  puts "Use file paths relative to the current directory in your terminal."
  puts "Optionally you may provide a key (5 digit number) to use for encryption."
  puts "You may also provide a date formatted DDMMYY."
  puts "Examples:"
  puts "'ruby encrypt.rb input.txt output.txt'"
  puts "'ruby encrypt.rb input.txt output.txt 12345'"
  puts "'ruby encrypt.rb input.txt output.txt 12345 070822'"
  puts "'ruby encrypt.rb input.txt output.txt 070822'"
  puts
end

run


