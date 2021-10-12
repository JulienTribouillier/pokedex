class PokeImportService

  def fetch_resource(resource_name, id_or_name: nil, limit: 10, offset: 0)
    request_url = "#{ENV['BASE_URI']}/#{resource_name}"
    request_url +=
      if id_or_name
        "/#{id_or_name}"
      else
        "?limit=#{limit}&offset=#{offset}"
      end
    response = HTTParty.get(request_url)
    JSON.parse(response.body, object_class: OpenStruct)
    # it seems much more easier to work with OpenStruct object
  end

  def fetch_pokemon_list(limit = 10, offset = 0)
    fetch_resource('pokemon', limit: limit, offset: offset)
  end

  def fetch_one_pokemon(id_or_name)
    fetch_resource('pokemon', id_or_name: id_or_name)
  end

  def fetch_type_list(limit = 25, offset = 0)
    fetch_resource('type', limit: limit, offset: offset)
  end


  # TODO: refacto old version (block in next comment)
  # def create_pokemon(id_or_name)
  #   request_url = api_connection(ressource: 'pokemon', id_or_name: id_or_name)
  #   parsed = JSON.parse(request_url)
  #   Pokemon.create_with(
  #     name: parsed['name'],
  #     num: parsed['id'],
  #     sprite: parsed['sprites']['front_default'],
  #     # types: import_type(parsed['types']),
  #     height: parsed['height'],
  #     weight: parsed['weight']
  #   ).find_or_create_by(
  #     name: parsed['name']
  #   )
  # end
  #
  # def import_pokemon_list
  #   request_url = api_connection(ressource: 'pokemon')
  #   parsed = JSON.parse(request_url)
  #   parsed['results'].each do |p|
  #     create_pokemon(p['name'])
  #   end
  # end



end
