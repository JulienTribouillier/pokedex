class PokemonsController < ApplicationController

  def index
    @pokemon = Pokemon.page params[:page]
  end

  def show
    @pokemon = Pokemon.find(params[:id])
  end
end
