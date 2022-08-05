RSpec.describe Decryptor do
  let(:decryptor) {Decryptor.new("02715", "040895")}

  it 'exists and has attributes' do
    expect(decryptor).to be_an(Decryptor)
    expect(decryptor.shifters).to all(be_instance_of(Shifter))
  end
  
  it 'can decrypt a message with no edge cases' do
    expect(decryptor.decrypt("keder ohulw")).to eq("hello world")
  end

  it 'can decrypt edge cases' do
    expect(decryptor.decrypt("keder!sprrdx?")).to eq("hello! world?")
  end

end