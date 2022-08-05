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
end