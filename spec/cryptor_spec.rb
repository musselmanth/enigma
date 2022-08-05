RSpec.describe Cryptor do

  context 'encrypt' do
    let(:encryptor) {Cryptor.new("02715", "040895", :encrypt)}

    it 'exists and has attributes' do
      expect(encryptor).to be_instance_of(Cryptor)
      expect(encryptor.shifters).to all(be_instance_of(Shifter))
    end
    
    it 'can encrypt a message with no edge cases' do
      expect(encryptor.run("hello world")).to eq("keder ohulw")
    end

    it 'can encrypt edge cases' do
      expect(encryptor.run("Hello! WORLD?")).to eq("keder!sprrdx?")
    end
  end

  context 'decrypt' do
    let(:decryptor) {Cryptor.new("02715", "040895", :decrypt)}

    it 'exists and has attributes' do
      expect(decryptor).to be_instance_of(Cryptor)
      expect(decryptor.shifters).to all(be_instance_of(Shifter))
    end
    
    it 'can decrypt a message with no edge cases' do
      expect(decryptor.run("keder ohulw")).to eq("hello world")
    end
  
    it 'can decrypt edge cases' do
      expect(decryptor.run("keder!sprrdx?")).to eq("hello! world?")
    end

  end

end