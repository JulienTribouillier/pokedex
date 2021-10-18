# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PokeImportService, type: :request do

  before do
    @poke_api = PokeImportService.new
  end

  describe '#fetch_resource' do
    context 'when default parameters'
    it 'can return an openstruct object' do
      expect(@poke_api.fetch_resource('pokemon').class).to be(OpenStruct)
    end

    context 'when pokemon parameter'
    it 'can fetch pokemon bulbasaur' do
      expect(@poke_api.fetch_resource('pokemon').results.first.name).to eq('bulbasaur')
    end

    context 'when only type parameter'
    it 'can connect to api and fetch all 20 types' do
      expect(@poke_api.fetch_resource('type').results.first.name).to eq('normal')
      expect(@poke_api.fetch_resource('type').results.last.name).to eq('fire')
    end

    context 'when change the limit parameter'
    it 'change total of fetched object' do
      expect(@poke_api.fetch_resource('type', limit: 1).results.count).to eq(1)
      expect(@poke_api.fetch_resource('type', limit: 10).results.count).to eq(10)
      expect(@poke_api.fetch_resource('pokemon', limit: 1).results.count).to eq(1)
      expect(@poke_api.fetch_resource('pokemon', limit: 5).results.count).to eq(5)
    end
  end

  describe '#fetch_pokemon_list' do
    context 'when no parameters specified'
    it 'fetch 10 Pokemons' do
      expect(@poke_api.fetch_pokemon_list.results.count).to eq(10)
    end

    context 'when 1 limit is specified'
    it 'fetch one pokemon' do
      expect(@poke_api.fetch_pokemon_list(1).results.count).to eq(1)
    end

    context 'when 1 limit and 1 offset is specified'
    it 'fetch the second pokemon in api list ivysaur' do
      expect(@poke_api.fetch_pokemon_list(1, 1).results.first.name).to eq('ivysaur')
    end
  end

  describe '#fetch_one_pokemon' do
    context 'when id 10 in parameters'
    it 'fetch pokemon with id 10' do
      expect(@poke_api.fetch_one_pokemon(10).class).to be(OpenStruct)
    end
  end

  describe '#fetch_type_list' do
    context 'when no parameters specified'
    it 'fetch 20 types' do
      expect(@poke_api.fetch_type_list.results.count).to eq(20)
    end

    context 'when 1 limit is specified'
    it 'fetch one type' do
      expect(@poke_api.fetch_type_list(1).results.count).to eq(1)
    end

    context 'when 1 limit and 1 offset is specified'
    it 'fetch the second pokemon in api list ivysaur' do
      expect(@poke_api.fetch_type_list(1, 1).results.first.name).to eq('fighting')
    end
  end

  describe '#import_fetched_resources' do
    context 'when defaults parameters are defined'
    it 'import 10 pokemons and add correct type association' do
      @poke_api.import_fetched_resources('pokemon')
      expect(Pokemon.count).to eq(10)
      expect(Pokemon.first.types.first.name).to eq('grass')
    end

    context 'when fix the limit to 1'
    it 'import only the first pokemon' do
      @poke_api.import_fetched_resources('pokemon', limit: 1)
      expect(Pokemon.count).to eq(1)
    end
  end

  describe '#import_one_pokemon' do
    context 'when trying to import Pokemon with ID 120'
    it 'import one pokemon with correct ID' do
      @poke_api.import_one_pokemon('120')
      expect(Pokemon.count).to eq(1)
      expect(Pokemon.first.num).to eq(120)
    end

    it 'returns a Pokemon class' do
      pokemon = @poke_api.send(:import_one_pokemon, 1)
      expect(pokemon).to be_an_instance_of(Pokemon)
    end
  end

  describe '#import_one_type' do
    it 'import type with good id' do
      @poke_api.fetch_resource('type')
      @poke_api.import_one_type('1')
      expect(Type.count).to eq(1)
      expect(Type.last.name).to eq('normal')
    end

    it 'returns a Type class' do
      pokemon = @poke_api.send(:import_one_type, 1)
      expect(pokemon).to be_an_instance_of(Type)
    end
  end

  describe '#get_types' do
    it 'returns an array of Type' do
      fetched_types = @poke_api.send(:fetch_one_pokemon, 3).types
      types = @poke_api.send(:get_types, fetched_types)

      expect(types.first.name).to eq('grass')
      expect(types.last.name).to eq('poison')

    end
  end

  describe '#import_type_list' do
    context 'when no limits specified'
    it 'import types in database' do
      @poke_api.import_type_list
      expect(Type.count).to eq(20)
      expect(Type.last.name).to eq('shadow')
    end
  end

  describe '#import_pokemon_list' do
    context 'with limit = 1'
    it 'import one pokemon in database' do
      @poke_api.import_pokemon_list(1)
      expect(Pokemon.count).to eq(1)
    end
  end

end
