class CreatePokemonsTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemons_types do |t|
      t.belongs_to :pokemon, index: true
      t.belongs_to :type, index: true
      t.timestamps
    end
  end
end
