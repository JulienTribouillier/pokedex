require 'rails_helper'

RSpec.describe Api::V1::PokemonsController, type: :controller do
  describe 'GET /index' do
    it 'renders the index template' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'renders json' do
      get :index
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe 'GET /show:id' do
    it 'renders the show template' do
      Pokemon.create(name: 'toto')
      get :show, params: { id: Pokemon.first.id}
      expect(response.status).to eq(200)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end
end
