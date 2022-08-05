RSpec.describe Encryptor do
  let(:encryptor) {Encryptor.new("02715", "040895")}

  it 'exists and has attributes' do
    expect(encryptor).to be_an(Encryptor)
    expect(encryptor.date).to eq("040895")
    expect(encryptor.key).to eq("02715")
    expect(encryptor.shifters).to all(be_instance_of(Shifter))
  end
  
  it 'can encrypt a message with no edge cases' do
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }
    expect(encryptor.encrypt("hello world")).to eq(expected)
  end

  it 'can encrypt edge cases' do
    expected = {
      encryption: "keder!sprrdx?",
      key: "02715",
      date: "040895"
    }
    expect(encryptor.encrypt("Hello! WORLD?")).to eq(expected)
  end

end