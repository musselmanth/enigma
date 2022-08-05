RSpec.describe Enigma do

  let(:enigma) { Enigma.new }

  it 'exists' do
    expect(enigma).to be_an Enigma
  end

  it 'encripts a message when the key and date are provided' do
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }
    expect(enigma.encrypt("hello world", "02715", "040895")).to eq(expected)
  end

  it 'can use todays date if one is not provided' do
    allow(Time).to receive(:now).and_return(Time.new(1995, 8, 4))
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }
    expect(enigma.encrypt("hello world", "02715")).to eq(expected)
  end

end