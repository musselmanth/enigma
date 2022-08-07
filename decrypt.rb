require './lib/enigma.rb'

def run
  if !valid_arguments?
    puts "Please include two .txt input and output file names, a key, and a date formatted like the example below."
    puts "The input file should be in the same directory as the 'decrypt.rb' file."
    puts "The key should be a 5 digit number"
    puts "The date should be a 6 digit number formatted DDMMYY"
    puts "Example: 'ruby decrypt.rb input.txt output.txt 07134 070822'"
    exit
  end
  input_file_path = ARGV[0]
  output_file_path = ARGV[1]
  key = ARGV[2]
  date = ARGV[3]

  input = File.open(input_file_path, "r")
  output = File.open(output_file_path, "w")
  

  enigma = Enigma.new
  decrypted = enigma.decrypt(input.read, key, date)
  output.write(decrypted[:decryption])

  puts "Created '#{output_file_path}' with the key #{decrypted[:key]} and the date #{decrypted[:date]}."
end

def valid_arguments?
  ARGV.length == 4 &&
  ARGV[0][-4..-1] == ".txt" &&
  File.exist?(ARGV[0]) &&
  ARGV[1][-4..-1] == ".txt" &&
  ARGV[2].length == 5 &&
  ARGV[2].to_i.to_s.rjust(5, "0") == ARGV[2] &&
  ARGV[3].length == 6 &&
  ARGV[3].to_i.to_s.rjust(6, "0") == ARGV[3]
end

run


