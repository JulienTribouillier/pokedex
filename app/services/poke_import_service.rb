class PokeImportService

  def api_connection(ressource: 'pokemon', limit: nil, offset: nil, id_or_name: nil)
    url =
      if id_or_name.nil?
        "#{ENV['BASE_URI']}/#{ressource}/?limit=#{limit}&offset=#{offset}"
      else
        "#{ENV['BASE_URI']}/#{ressource}/#{id_or_name}"
      end
    HTTParty.get(url).body
  end

  # def import_type(id_or_name)
  #   request_url = api_connection(ressource: 'type')
  #   parsed = JSON.parse(request_url)
  #   types = []
  #   parsed['results'].each do |t|
  #     types << Type.find_by(name: t['type']['name'])
  #   end
  #   types
  # end

  def create_pokemon(id_or_name)
    request_url = api_connection(ressource: 'pokemon', id_or_name: id_or_name)
    parsed = JSON.parse(request_url)
    Pokemon.create_with(
      name: parsed['name'],
      num: parsed['id'],
      sprite: parsed['sprites']['front_default'],
      # types: import_type(parsed['types']),
      height: parsed['height'],
      weight: parsed['weight']
    ).find_or_create_by(
      name: parsed['name']
    )
  end

  def import_pokemon_list
    request_url = api_connection(ressource: 'pokemon')
    parsed = JSON.parse(request_url)
    parsed['results'].each do |p|
      create_pokemon(p['name'])
    end
  end



end
