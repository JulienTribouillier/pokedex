class Pokemon < ApplicationRecord
  has_many :pokemons_types
  has_many :types, through: :pokemons_types
end
