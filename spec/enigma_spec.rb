RSpec.describe Enigma do

  let(:enigma) { Enigma.new }

  it 'exists' do
    expect(enigma).to be_an Enigma
  end

  it 'encrypts a message when the key and date are provided' do
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

  it 'can get a random key if one isnt provided' do
    allow(Time).to receive(:now).and_return(Time.new(1995, 8, 4))
    allow(enigma).to receive(:rand).and_return(2715)
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }
    expect(enigma.encrypt("hello world")).to eq(expected)
  end

  it 'can decrypt a message when the key and date are provided' do
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }
    expect(enigma.decrypt("keder ohulw", "02715", "040895")).to eq(expected)
  end

  it 'can decrypt a message with todays date' do
    allow(Time).to receive(:now).and_return(Time.new(1995, 8, 4))
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }
    expect(enigma.decrypt("keder ohulw", "02715")).to eq(expected)
  end

  it 'can crack a message when the date is provided' do
    expected = {
      decryption: "hello world end",
      date: "040895",
      key: "02715"
    }
    expect(enigma.crack("keder ohulwthnw", "040895")).to eq(expected)
  end

  it 'can crack a message with todays date' do
    allow(Time).to receive(:now).and_return(Time.new(1995, 8, 4))
    expected = {
      decryption: "hello world end",
      date: "040895",
      key: "02715"
    }
    expect(enigma.crack("keder ohulwthnw")).to eq(expected)
  end

end