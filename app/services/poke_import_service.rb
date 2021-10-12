class PokeImportService
  # TODO: rspec test

  def import_pokemon_list(limit = 10, offset = 0)
    # change the limit to 1200 to have all pokemons in database
    import_fetched_resources('pokemon', limit: limit, offset: offset)
  end

  def import_type_list(limit = 11, offset = 0)
    import_fetched_resources('type', limit: limit, offset: offset)
  end

  def fetch_resource(resource_name, id_or_name: nil, limit: 10, offset: 0)
    request_url = "#{ENV['BASE_URI']}/#{resource_name}"
    request_url +=
      if id_or_name
        "/#{id_or_name}"
        # this url is made to have specifics request, like one pokemon or one type
      else
        "?limit=#{limit}&offset=#{offset}"
        # this part of the url set the limit of resources we want to fetch
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

  def import_fetched_resources(resource_name, limit: 10, offset: 0)
    fetched_resource = send("fetch_#{resource_name}_list", limit, offset)
    fetched_resource.results.each do |p|
      send("import_one_#{resource_name}", p.name)
    end
  end

  def import_one_pokemon(id_or_name)
    fetched_pokemon = fetch_one_pokemon(id_or_name)

    Pokemon.find_or_create_by(name: fetched_pokemon.name) do |p|
      p.num = fetched_pokemon.id
      p.sprite = fetched_pokemon.sprites.front_default
      p.height = fetched_pokemon.height
      p.weight = fetched_pokemon.weight
      p.types = get_types(fetched_pokemon.types)
    end
  end

  def import_one_type(id_or_name)
    Type.find_or_create_by(name: id_or_name)
  end

  def get_types(fetch_types)
    fetch_types.map { |t| Type.find_or_create_by!(name: t.type.name) }
  end
end
