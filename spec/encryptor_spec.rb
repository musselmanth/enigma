RSpec.describe Encryptor do
  let(:encryptor) {Encryptor.new}

  it 'can encrypt a message with no edge cases' do
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }
    expect(encryptor.encrypt("hello world", "02715", "040895")).to eq(expected)
  end
  
end