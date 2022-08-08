require './lib/enigma.rb'
require 'date'

def run
  args = get_cl_arguments
  input = File.open(args[:input], "r")
  output = File.open(args[:output], "w")
  cipher = input.read
  
  enigma = Enigma.new
  decrypted = enigma.decrypt(cipher, args[:key], args[:date])
  output.write(decrypted[:decryption])

  puts "Created '#{args[:output]}' with the key #{decrypted[:key]} and the date #{decrypted[:date]}."
end

def get_cl_arguments
  unless valid_arguments?
    invalid_arguments_output
    exit
  end
  {input: ARGV[0], output: ARGV[1], key: ARGV[2], date: ARGV[3]}
end

def valid_arguments?
  (ARGV.length == 3 || ARGV.length == 4) &&
  File.extname(ARGV[0]) == ".txt" &&
  File.extname(ARGV[1]) == ".txt" &&
  File.exist?(ARGV[0]) &&
  ARGV[2].length == 5 &&
  ARGV[2].to_i.to_s.rjust(5, "0") == ARGV[2] &&
  (ARGV[3] ? ARGV[3].length == 6 : true) && 
  (ARGV[3] ? Date.valid_date?(ARGV[3][4..5].to_i, ARGV[3][2..3].to_i, ARGV[3][0..1].to_i) : true)
end

def invalid_arguments_output
  puts "\nPlease include two .txt input and output file names, a key, and a date formatted like the example below."
  puts "If no date is provided, todays date will be used."
  puts "Use file paths relative to the current directory in your terminal."
  puts "The key should be a 5 digit number."
  puts "The date should be a 6 digit number formatted DDMMYY."
  puts "Examples: "
  puts "'ruby decrypt.rb input.txt output.txt 07134 070822'"
  puts "'ruby decrypt.rb input.txt output.txt 07134'\n\n"
end

run


