require 'rails_helper'

RSpec.describe PokemonsType, type: :model do
  describe 'join table association' do
    it { should belong_to(:pokemon) }
    it { should belong_to(:type) }
  end
end
