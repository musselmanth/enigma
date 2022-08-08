RSpec.describe Shifter do
  
  context 'encrypt' do
    let(:d_shifter) { Shifter.new(20) }

    it 'exists' do
      expect(d_shifter).to be_instance_of(Shifter)
    end

    it 'has a shift' do
      expect(d_shifter.shift).to eq(20)
    end

    it 'can shift a character' do
      expect(d_shifter.shift_character("a")).to eq("u")
      expect(d_shifter.shift_character("l")).to eq("e")
    end

    it 'can factory itself for encryption' do
      shifters = Shifter.generate_shifters("02715", "040895", :encrypt)
      expect(shifters).to all(be_instance_of(Shifter))
      expect(shifters[0].shift).to eq(3)
      expect(shifters[1].shift).to eq(27)
      expect(shifters[2].shift).to eq(73)
      expect(shifters[3].shift).to eq(20)
    end

  end

  context 'decrypt' do
    let(:d_shifter) { Shifter.new(-20) }

    it 'can shift a character with a negative shift' do
      expect(d_shifter.shift_character("u")).to eq("a")
      expect(d_shifter.shift_character("e")).to eq("l")
    end

    it 'can factory itself with negative shifts for decryption' do
      shifters = Shifter.generate_shifters("02715", "040895", :decrypt)
      expect(shifters).to all(be_instance_of(Shifter))
      expect(shifters[0].shift).to eq(-3)
      expect(shifters[1].shift).to eq(-27)
      expect(shifters[2].shift).to eq(-73)
      expect(shifters[3].shift).to eq(-20)
    end

  end

end