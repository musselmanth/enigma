require './lib/enigma.rb'
require 'date'

def run
  args = get_cl_arguments
  input = File.read(args[:input_path])
  enigma = Enigma.new
  output = enigma.encrypt(input, args[:key], args[:date]) if args[:action] == :encrypt
  output = enigma.decrypt(input, args[:key], args[:date]) if args[:action] == :decrypt
  output = enigma.crack(input, args[:date]) if args[:action] == :crack
  output[:result] = output.delete(:decryption) if args[:action] == :decrypt || args[:action] == :crack
  output[:result] = output.delete(:encryption) if args[:action] == :encrypt
  output_file = File.open(args[:output_path], "w")
  output_file.write(output[:result])
  puts "Created '#{args[:output_path]}' with the key #{output[:key]} and the date #{output[:date]}."
end

def get_cl_arguments
  help_output if ARGV.include?("--help")
  args = {}
  args[:action] = :encrypt if ARGV.include?("--encrypt")
  args[:action] = :decrypt if ARGV.include?("--decrypt")
  args[:action] = :crack if ARGV.include?("--crack")
  args[:key] = (ARGV.include?("-k") ? ARGV[ARGV.index("-k") + 1] : nil)
  args[:date] = (ARGV.include?("-d") ? ARGV[ARGV.index("-d") + 1] : nil)
  args[:input_path] = (ARGV.include?("-i") ? ARGV[ARGV.index("-i") + 1] : nil)
  args[:output_path] = (ARGV.include?("-o") ? ARGV[ARGV.index("-o") + 1] : nil)
  error_output unless valid_arguments?(args) 
  args
end

def valid_arguments?(args)
  args[:action] && args[:input_path] && args[:output_path] &&
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
  puts "\nRun 'ruby enigma_runner.rb' with one of the three following action flags:\n" +
       "\n--encrypt\n" +
       "  Requires -i and -o flags with input and output files.\n" +
       "  If no key is provided, one will be generated randomly.\n" +
       "  If no date is provided, today's date will be used.\n" +
       "\n--decrypt\n" +
       "  Requires -i and -o flags with input and output files.\n" +
       "  Also requires a key be provided with the -k flag.\n" +
       "  If no date is provided, today's date will be used.\n" +
       "\n--crack\n" +
       "  Requires -i and -o flags with input and output files.\n" +
       "  Does not take a key. if one is provided it will be ignored.\n" +
       "  If no date is provided, today's date will be used.\n" +
       "\nOther Flags:\n" +
       "  -i file_path.txt\n" +
       "    Input file path. File must exist and be a .txt file.\n" +
       "  -o file_path.txt\n" +
       "    Output file path. If file does not exist it will be created. Must be .txt file.\n" +
       "  -k #####\n" +
       "    Key for encryption / decryption. Key must be a five digit number.\n" +
       "  -d DDMMYY\n" +
       "    Date of encryption. Must be a valid date and formatted as above.\n" +
       "\nExamples: 'ruby enigma_runner.rb --encrypt -i input.txt -o output.txt -k 12345 -d 150722'\n" +
         "          'ruby enigma_runner.rb --decrypt -i input.txt -o output.txt -k 94857'\n" +
         "          'ruby enigma_runner.rb --crack -i input.txt -o output.txt -d 070822'\n\n" 
  exit
end

run