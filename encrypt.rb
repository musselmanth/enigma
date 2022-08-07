require './lib/enigma.rb'

def run
  if !valid_arguments?
    puts "Please include two .txt input and output file names formatted like the example below."
    puts "The input file should be in the same directory as the 'encrypt.rb' file."
    puts "Example: 'ruby encrypt.rb input.txt output.txt'"
    exit
  end
  input_file_path = ARGV[0]
  output_file_path = ARGV[1]

  input = File.open(input_file_path, "r")
  output = File.open(output_file_path, "w")

  enigma = Enigma.new
  encrypted = enigma.encrypt(input.read)
  output.write(encrypted[:encryption])

  puts "Created '#{output_file_path}' with the key #{encrypted[:key]} and the date #{encrypted[:date]}."
end

def valid_arguments?
  ARGV.length == 2 &&
  ARGV[0][-4..-1] == ".txt" &&
  File.exist?(ARGV[0]) &&
  ARGV[1][-4..-1] == ".txt"
end

run


