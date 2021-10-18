class Ability < ApplicationRecord
  has_many :pokemons_abilities
  has_many :pokemons, through: :pokemons_abilities

  validates :name, presence: true
end
