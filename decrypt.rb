require './lib/enigma.rb'

def run
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
  cipher = input.read
  
  enigma = Enigma.new
  decrypted = enigma.decrypt(cipher, key, date)
  output.write(decrypted[:decryption])

  puts "Created '#{output_file_path}' with the key #{decrypted[:key]} and the date #{decrypted[:date]}."
end

def valid_arguments?
  (ARGV.length == 3 || ARGV.length == 4) &&
  ARGV[0][-4..-1] == ".txt" &&
  ARGV[1][-4..-1] == ".txt" &&
  ARGV[2].length == 5 &&
  ARGV[2].to_i.to_s.rjust(5, "0") == ARGV[2] &&
  (ARGV[3] ? ARGV[3].length == 6 : true) && 
  (ARGV[3] ? ARGV[3].to_i.to_s.rjust(6, "0") == ARGV[3] : true )
end

def invalid_arguments_output
  puts
  puts "Please include two .txt input and output file names, a key, and a date formatted like the example below."
  puts "If no date is provided, todays date will be used."
  puts "Use file paths relative to the current directory in your terminal."
  puts "The key should be a 5 digit number."
  puts "The date should be a 6 digit number formatted DDMMYY."
  puts "Examples: "
  puts "'ruby decrypt.rb input.txt output.txt 07134 070822'"
  puts "'ruby decrypt.rb input.txt output.txt 07134'"
  puts
end

run


