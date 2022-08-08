require './lib/enigma.rb'
require 'date'

def run
  args = get_cl_arguments
  input = File.open(args[:input], "r")
  output = File.open(args[:output], "w")
  message = input.read

  enigma = Enigma.new
  encrypted = enigma.encrypt(message, args[:key], args[:date])
  output.write(encrypted[:encryption])

  puts "Created '#{args[:output]}' with the key #{encrypted[:key]} and the date #{encrypted[:date]}."
end

def get_cl_arguments
  key = ARGV.include?("-k") ? ARGV[ARGV.index("-k") + 1] : nil
  date = ARGV.include?("-d") ? ARGV[ARGV.index("-d") + 1] : nil
  args = {input: ARGV[0], output: ARGV[1], key: key, date: date}
  unless valid_arguments?(args)
    invalid_arguments_output
    exit
  end
  args
end

def valid_arguments?(args)
  File.extname(args[:input]) == ".txt" &&
  File.extname(args[:output]) == ".txt" &&
  File.exist?(args[:input]) &&
  (args[:key] ? args[:key].length == 5 : true) &&
  (args[:key] ? args[:key].to_i.to_s.rjust(5, "0") == args[:key] : true) &&
  (args[:date] ? args[:date].length == 6 : true) &&
  (args[:date] ? Date.valid_date?(args[:date][4..5].to_i, args[:date][2..3].to_i, args[:date][0..1].to_i) : true)
end

def invalid_arguments_output
  puts "\nPlease include two .txt input and output file names formatted like the example below."
  puts "Optional flags: "
  puts "-k #####     Provide a five digit key to use for encryption."
  puts "-d DDMMYY    Provide a specific six digit date to use for encryption."
  puts "Example: ruby encrypt.rb input.txt output.txt -k 12345 -d 151221\n\n"
end

run


