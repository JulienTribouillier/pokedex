require 'rails_helper'

RSpec.describe Type, type: :model do
  it 'is not valid with no attributes' do
    expect(Type.new).to be_invalid
  end
  it 'is not valid without a name' do
    type = Type.new(name: nil)
    expect(type).to be_invalid
  end
  it 'is valid with a name' do
    type = Type.new(name: 'Tata')
    expect(type).to be_valid
  end
  describe 'associations' do
    it {should have_many(:pokemons_types)}
    it {should have_many(:pokemons)}
  end
end
