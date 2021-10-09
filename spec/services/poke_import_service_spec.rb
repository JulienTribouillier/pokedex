# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PokeImportService, type: :request do

  before do
    @poke_api = PokeImportService.new
  end

  describe '#api_connection' do
    context 'when no parameters specified'
    it 'can connect to api and fetch 20 pokemons' do
      expect(@poke_api.api_connection['pokemon/20/']).to eq('pokemon/20/')
      expect(@poke_api.api_connection['pokemon/21/']).to eq(nil)
    end

    context 'when only type parameter is specified'
    it 'can connect to api and fetch all 20 types' do
      expect(@poke_api.api_connection(ressource: 'type')['"count":20']).to eq('"count":20')
    end

    context 'when id_or_name 1 is specified with pokemon parameter'
    it 'can fetch first pokemon bulbasaur but not the second ivysaur' do
      expect(@poke_api.api_connection(ressource: 'pokemon', id_or_name: '1')['bulbasaur']).to eq('bulbasaur')
      expect(@poke_api.api_connection(ressource: 'pokemon', id_or_name: '1')['ivysaur']).to eq(nil)
    end

    context 'when id_or_name 1 is specified with type parameter'
    it 'can fetch first type' do
      expect(@poke_api.api_connection(ressource: 'type', id_or_name: '1')['normal']).to eq('normal')
    end
  end
end
