RSpec.describe Cracker do
  xit 'can crack a key with a cipher and date' do
    expect(Cracker.crack_key("keder ohulwthnw", "040895")).to eq("02715")
  end

  it 'can get a key for which letter was used for each shifter' do
    expect(Cracker.get_shift_amounts("keder ohulwthnw")).to eq([-7, 3, 0, 19])
  end

  it 'can reorder the shift amounts so they match the index of the shifters' do
    expect(Cracker.order_shift_amounts([-7, 3, 0, 19], 2)).to eq([3, 0, 19, -7])
  end

  it 'can subtract the offsets from the shift amounts and make the results not negative' do
    expect(Cracker.get_raw_key_segments([1, 0, 2, 5], [3, 0, 19, -7])).to eq([2, 0, 17, 15])
  end

  it 'can get the real key_segments from the raw_key_segments' do
    expect(Cracker.get_possible_key_segments([2, 0, 17, 15])).to eq([[2, 29, 56, 83], [0, 27, 54, 81], [17, 44, 71, 98], [15, 42, 69, 96]])
  end

end