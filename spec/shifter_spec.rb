RSpec.describe Shifter do
  let(:d_shifter) { Shifter.new(20) }

  it 'exists' do
    expect(d_shifter).to be_instance_of(Shifter)
  end

  it 'has a shift' do
    expect(d_shifter.shift).to eq(20)
  end

  it 'can shift a character' do
    expect(d_shifter.encrypt_character("a")).to eq("u")
    expect(d_shifter.encrypt_character("l")).to eq("e")
  end

  it 'doesnt shift characters not in the character set' do
    expect(d_shifter.encrypt_character("!")).to eq("!")
    expect(d_shifter.encrypt_character("6")).to eq("6")
  end

  it 'encrypts capitals as lowercase' do
    expect(d_shifter.encrypt_character("L")).to eq("e")
  end

  it 'can factory itself' do
    shifters = Shifter.generate_shifters("02715", "040895")
    expect(shifters.values).to all(be_instance_of(Shifter))
    expect(shifters[:a].shift).to eq(3)
    expect(shifters[:b].shift).to eq(27)
    expect(shifters[:c].shift).to eq(73)
    expect(shifters[:d].shift).to eq(20)
  end

end