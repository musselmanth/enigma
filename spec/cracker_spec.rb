RSpec.describe Cracker do
  let(:cracker) {Cracker.new("keder ohulwthnw", "040895")}

  it 'can crack a key with a cipher and date' do
    expect(cracker.crack_key("keder ohulwthnw", "040895")).to eq("02715")
  end

  it 'can get a key for which letter was used for each shifter' do
    expect(cracker.get_shift_amounts("keder ohulwthnw")).to eq([-7, 3, 0, 19])
  end

  it 'can reorder the shift amounts so they match the index of the shifters' do
    expect(cracker.order_shift_amounts([-7, 3, 0, 19], 2)).to eq([3, 0, 19, -7])
  end

  it 'can subtract the offsets from the shift amounts and make the results not negative' do
    expect(cracker.get_lowest_key_segments([1, 0, 2, 5], [3, 0, 19, -7])).to eq([2, 0, 17, 15])
  end

  it 'can get all the possible key_segments from the lowest_key_segments' do
    expect(cracker.get_all_possible_key_segments([2, 0, 17, 15])).to eq([["02", "29", "56", "83"], ["00", "27", "54", "81"], ["17", "44", "71", "98"], ["15", "42", "69", "96"]])
  end

  it 'can take possible_key_segments and get the real ones' do
    input = [["02", "29", "56", "83"], ["00", "27", "54", "81"], ["17", "44", "71", "98"], ["15", "42", "69", "96"]]
    expect(cracker.get_matching_key_segments(input)).to eq(["02", "27", "71", "15"])
  end

  it 'can confirm whether a set of key segments is a valid solution' do
    expect(cracker.is_key_solution?(["02", "27", "71", "15"])).to be true
    expect(cracker.is_key_solution?(["12", "25", "51", "18"])).to be true
    expect(cracker.is_key_solution?(["12", "02", "27", "71"])).to be false
    expect(cracker.is_key_solution?(["15", "64", "34", "46"])).to be false
  end

  it 'can combine matching key segments into a key' do
    expect(cracker.combine_key_segments(["02", "27", "71", "15"])).to eq("02715")
    expect(cracker.combine_key_segments(["12", "23", "36", "61"])). to eq("12361")
  end

  it 'can crack a code given only a date' do
    expect(cracker.run("keder ohulwthnw")).to eq("hello world end")
  end

  it 'can tell you its key' do
    expect(cracker.key).to eq("02715")
  end

end