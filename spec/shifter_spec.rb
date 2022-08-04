RSpec.describe Shifter do
  let(a_shifter) { Shifter.new("02", "040895") }

  it 'exists' do
    expect(a_shifter).to be_instance_of(Shifter)
  end

  it 'has an offset' do
    expect(a_shifter.offset).to eq(3)
  end
end