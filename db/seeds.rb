# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Type.destroy_all
Pokemon.destroy_all

poke_service = PokeImportService.new

# poke_service.import_type_list(11)
# puts("#{Type.count} Types have been created successfully !")

poke_service.import_pokemon_list(20)
puts("#{Pokemon.count} Pokemons have been created successfully !")
