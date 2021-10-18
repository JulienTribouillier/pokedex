class CreatePokemonsAbilities < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemons_abilities do |t|
      t.belongs_to :pokemon, index: true
      t.belongs_to :ability, index: true
      t.timestamps
    end
  end
end
