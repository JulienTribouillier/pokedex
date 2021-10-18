# frozen_string_literal: true
class Api::V1::PokemonsController < ApplicationController
  def index
    pokemons = Pokemon.includes(:types).select(:id, :name, :num)
    render json: pokemons.to_json(only: %i[num name], include: { types: { only: :name } })
  end

  def show
    pokemon = Pokemon.includes(:types).find_by(num: params[:id])
    render json: pokemon.to_json(include: { types: { only: :name }, abilities: { only: :name } },
                                 except: %i[created_at updated_at] )
  end
end

