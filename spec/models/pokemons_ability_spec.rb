require 'rails_helper'

RSpec.describe PokemonsAbility, type: :model do
  describe 'join table association' do
    it { should belong_to(:pokemon) }
    it { should belong_to(:ability) }
  end
end
