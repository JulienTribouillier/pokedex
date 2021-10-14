class ImportPokemonsJob < ApplicationJob
  queue_as :default

  def perform(limit)
    poke_api = PokeImportService.new
    poke_api.import_pokemon_list(limit)
  end
end
