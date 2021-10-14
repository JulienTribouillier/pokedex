# frozen_string_literal: true
class Api::V1::PokemonsController < ApplicationController
  def index
    pokemons = Pokemon.includes(:types).select(:id, :name).order(:num)
    render json: pokemons.to_json(only: %i[id name], include: :types)
  end

  def show
    pokemon = Pokemon.includes(:types).find(params[:id])
    render json: pokemon.to_json(include: { types: { only: :name } })
  end
end

