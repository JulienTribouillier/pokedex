require 'rails_helper'

RSpec.describe PokemonsController, type: :controller do
  describe 'GET /index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /show:id' do
    it 'renders the show template' do
      Pokemon.create(name: 'toto')
      get :show, params: { id: Pokemon.first.id}
      expect(response).to render_template('show')
      expect(response.status).to eq(200)
    end
  end
end
