require './lib/enigma.rb'
require 'date'

def run
  args = get_cl_arguments
  input = File.open(args[:input], "r")
  output = File.open(args[:output], "w")
  encrypted_string = input.read
  enigma = Enigma.new
  cracked = enigma.crack(encrypted_string, args[:date])
  output.write(cracked[:decryption])
  puts "Created '#{args[:output]}' with the key #{cracked[:key]} and the date #{cracked[:date]}."
end

def get_cl_arguments
  unless valid_arguments?
    invalid_arguments_output
    exit
  end

  {input: ARGV[0], output: ARGV[1], date: ARGV[2]}
end

def valid_arguments?
  (ARGV.length == 3 || ARGV.length == 2) &&
  File.extname(ARGV[0]) == ".txt" &&
  File.extname(ARGV[1]) == ".txt" &&
  File.exist?(ARGV[0]) &&
  (ARGV[2] ? ARGV[2].length == 6 : true) &&
  (ARGV[2] ? Date.valid_date?(ARGV[2][4..5].to_i, ARGV[2][2..3].to_i, ARGV[2][0..1].to_i) : true)
end

def invalid_arguments_output
  puts "\nPlease include two .txt input and output file names, and a date formatted like the example below."
  puts "The date should be a 6 digit number formatted DDMMYY"
  puts "If no date is provided today's date will be used"
  puts "Example: 'ruby crack.rb input.txt output.txt 070822'\n\n"
end

run

