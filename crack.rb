require './lib/enigma.rb'

def run
  unless valid_arguments?
    invalid_arguments_output
    exit
  end

  input_file_path = ARGV[0]
  output_file_path = ARGV[1]
  date = ARGV[2]

  input = File.open(input_file_path, "r")
  output = File.open(output_file_path, "w")
  encrypted_string = input.read

  if !/^[a-zA-Z ]*$/.match?(encrypted_string[-4..-1])
    puts "Input file ends in invalid characters."
    exit
  end

  enigma = Enigma.new
  cracked = enigma.crack(encrypted_string, date)
  output.write(cracked[:decryption])

  puts "Created '#{output_file_path}' with the key #{cracked[:key]} and the date #{cracked[:date]}."
end

def valid_arguments?
  (ARGV.length == 3 || ARGV.length == 2) &&
  ARGV[0][-4..-1] == ".txt" &&
  File.exist?(ARGV[0]) &&
  ARGV[1][-4..-1] == ".txt" &&
  (ARGV[2] ? ARGV[2].length == 6 : true) &&
  (ARGV[2] ? ARGV[2].to_i.to_s.rjust(6, "0") == ARGV[2] : true)
end

def invalid_arguments_output
  puts
  puts "Please include two .txt input and output file names, and a date formatted like the example below."
  puts "The input file should be in the same directory as the 'crack.rb' file."
  puts "The date should be a 6 digit number formatted DDMMYY"
  puts "If no date is provided today's date will be used"
  puts "Example: 'ruby crack.rb input.txt output.txt 070822'"
  puts
end

run


