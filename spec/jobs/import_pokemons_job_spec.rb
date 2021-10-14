require 'rails_helper'

RSpec.describe ImportPokemonsJob, type: :job do
  context 'when limit = 10'
  it 'import 10 pokemon in database' do
    job = ImportPokemonsJob.new
    job.perform(10)
    expect(Pokemon.count).to eq(10)
  end
end
