RSpec.describe Cracker do
  xit 'can crack a key with a cipher and date' do
    expect(Cracker.crack_key("keder ohulwthnw", "040895")).to eq("02715")
  end

  it 'can get a key for which letter was used for each shifter' do
    expect(Cracker.shifter_key("keder ohulwthnw")).to eq(["d", " ", "e", "n"])
  end
end