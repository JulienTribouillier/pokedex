class ImportPokemonsJob < ApplicationJob
  queue_as :default

  def perform
    poke_api = PokeImportService.new
    poke_api.import_pokemon_list(1200)
  end
end
