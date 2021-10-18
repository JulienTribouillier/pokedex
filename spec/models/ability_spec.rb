require 'rails_helper'

RSpec.describe Ability, type: :model do
  it 'is not valid with no attributes' do
    expect(Ability.new).to be_invalid
  end
  it 'is not valid without a name' do
    ability = Ability.new(name: nil)
    expect(ability).to be_invalid
  end
  it 'is valid with a name' do
    ability = Ability.new(name: 'Tata')
    expect(ability).to be_valid
  end
  describe 'associations' do
    it {should have_many(:pokemons_abilities)}
    it {should have_many(:pokemons)}
  end
end
