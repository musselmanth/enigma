RSpec.describe Encryptor do
  let(:encryptor) {Encryptor.new("02715", "040895")}

  it 'exists and has attributes' do
    expect(encryptor).to be_an(Encryptor)
    expect(encryptor.shifters).to all(be_instance_of(Shifter))
  end
  
  it 'can encrypt a message with no edge cases' do
    expect(encryptor.encrypt("hello world")).to eq("keder ohulw")
  end

  it 'can encrypt edge cases' do
    expect(encryptor.encrypt("Hello! WORLD?")).to eq("keder!sprrdx?")
  end

end