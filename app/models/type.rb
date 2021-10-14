class Type < ApplicationRecord
  has_many :pokemons_types
  has_many :pokemons, through: :pokemons_types

  validates :name, presence: true
end
