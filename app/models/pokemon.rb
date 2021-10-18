class Pokemon < ApplicationRecord
  has_many :pokemons_types
  has_many :pokemons_abilities
  has_many :types, through: :pokemons_types
  has_many :abilities, through: :pokemons_abilities

  validates :name, presence: true

  def as_json(*args)
    super.tap { |hash| hash['id'] = hash.delete 'num' }
  end

  def to_param
    num
  end

end
