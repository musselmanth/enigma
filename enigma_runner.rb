require './lib/enigma.rb'
require 'date'

def run
  args = get_cl_arguments
  input = File.read(args[:input_path])
  
  encrypt_run(input, args[:output_path], args[:key], args[:date]) if args[:action] == :encrypt
  decrypt_run(input, args[:output_path], args[:key], args[:date]) if args[:action] == :decrypt
  crack_run(input, args[:output_path], args[:date]) if args[:action] == :crack
end

def encrypt_run(input, output_path, key, date)
  enigma = Enigma.new
  output = enigma.encrypt(input, key, date)
  output_file = File.open(output_path, "w")
  output_file.write(output[:encryption])
  puts "Encrypted message in '#{output_path}' with the key #{output[:key]} and the date #{output[:date]}."
end

def decrypt_run(input, output_path, key, date)
  enigma = Enigma.new
  output = enigma.decrypt(input, key, date)
  output_file = File.open(output_path, "w")
  output_file.write(output[:decryption])
  puts "Decrypted message in '#{output_path}' with the key #{output[:key]} and the date #{output[:date]}."
end

def crack_run(input, output_path, date)
  enigma = Enigma.new
  output = enigma.crack(input, date)
  output_file = File.open(output_path, "w")
  output_file.write(output[:decryption])
  puts "Cracked message in '#{output_path}' with the key #{output[:key]} and the date #{output[:date]}."
end

def get_cl_arguments
  help_output if ARGV.include?("--help")
  args = {}
  args[:action] = :encrypt if ARGV.include?("--encrypt") || ARGV.include?("-e")
  args[:action] = :decrypt if ARGV.include?("--decrypt") || ARGV.include?("-d")
  args[:action] = :crack if ARGV.include?("--crack") || ARGV.include?("-c")
  args[:key] = (ARGV.include?("-k") ? ARGV[ARGV.index("-k") + 1] : nil)
  args[:date] = (ARGV.include?("-d") ? ARGV[ARGV.index("-d") + 1] : nil)
  args[:input_path] = (ARGV.include?("-i") ? ARGV[ARGV.index("-i") + 1] : nil)
  args[:output_path] = (ARGV.include?("-o") ? ARGV[ARGV.index("-o") + 1] : nil)
  unless valid_arguments?(args) 
    error_output
  end
  args
end

def valid_arguments?(args)
  args[:action] &&
  args[:input_path] &&
  args[:output_path] &&
  File.extname(args[:input_path]) == ".txt" &&
  File.extname(args[:output_path]) == ".txt" &&
  File.exist?(args[:input_path]) &&
  (args[:date] ? args[:date].length == 6 : true) &&
  (args[:date] ? Date.valid_date?(args[:date][4..5].to_i, args[:date][2..3].to_i, args[:date][0..1].to_i) : true) &&
  (args[:key] ? args[:key].length == 5 : true) &&
  (args[:key] ? args[:key].to_i.to_s.rjust(5, "0") == args[:key] : true) &&
  (args[:action] == :decrypt ? args[:key] : true)
end

def error_output
  puts "\nArguments are not valid. Run 'ruby enigma_runner.rb --help' for more information.\n\n"
  exit
end

def help_output
  puts "\nRun 'ruby enigma_runner.rb' with one of the three following action flags:"
  puts "\n--encrypt"
  puts "  Requires -i and -o flags with input and output files."
  puts "  If no key is provided, one will be generated randomly."
  puts "  If no date is provided, today's date will be used."
  puts "\n--decrypt"
  puts "  Requires -i and -o flags with input and output files."
  puts "  Also requires a key be provided with the -k flag."
  puts "  If no date is provided, today's date will be used."
  puts "\n--crack"
  puts "  Requires -i and -o flags with input and output files."
  puts "  Does not take a key. if one is provided it will be ignored."
  puts "  If no date is provided, today's date will be used."
  puts "\nOther Flags:"
  puts "  -i file_path.txt"
  puts "    Input file path. File must exist and be a .txt file."
  puts "  -o file_path.txt"
  puts "    Output file path. If file does not exist it will be created. Must be .txt file."
  puts "  -k #####"
  puts "    Key for encryption / decryption. Key must be a five digit number."
  puts "  -d DDMMYY"
  puts "    Date of encryption. Must be a valid date and formatted as above."
  puts "\nExamples: 'ruby enigma_runner.rb --encrypt -i input.txt -o output.txt -k 12345 -d 150722'"
  puts   "          'ruby enigma_runner.rb --decrypt -i input.txt -o output.txt -k 94857'"
  puts   "          'ruby enigma_runner.rb --crack -i input.txt -o output.txt -d 070822'\n\n"
  exit
end

run