require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  it 'is not valid with no attributes' do
    expect(Pokemon.new).to be_invalid
  end
  it 'is not valid without a name' do
    pokemon = Pokemon.new(name: nil)
    expect(pokemon).to be_invalid
  end
  it 'is valid with a name' do
    pokemon = Pokemon.new(name: 'Toto')
    expect(pokemon).to be_valid
  end
end
